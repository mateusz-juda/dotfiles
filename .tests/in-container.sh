#!/bin/bash
# Runs inside the chezmoi-test container; started by .tests/apply.sh.
# Uses the fake submodule name "personal".
set -euo pipefail

# CHEZMOI_VERSION=x.y.z installs that release; "image" keeps the image's chezmoi.
if [ "${CHEZMOI_VERSION:-image}" != image ]; then
    curl -fsLS get.chezmoi.io | sh -s -- -b /tmp/bin -t "v$CHEZMOI_VERSION" >/dev/null 2>&1
    export PATH=/tmp/bin:$PATH
fi
echo "=== $(chezmoi --version | cut -d, -f1)"

export XDG_CACHE_HOME=/tmp/cache   # download externals once per run
git config --global user.name test
git config --global user.email test@example.invalid
git config --global init.defaultBranch main

fails=0
ok()   { echo "ok   $*"; }
fail() { echo "FAIL $*"; fails=$((fails + 1)); }
check() { local msg=$1; shift; if "$@"; then ok "$msg"; else fail "$msg"; fi; }

cfg=/tmp/chezmoi.toml
echo 'umask = 0o022' > "$cfg"

# cz <home> <source> <chezmoi args...>; stdin closed so any prompt fails the run.
cz() {
    local home=$1 src=$2; shift 2
    HOME=$home chezmoi --config "$cfg" --source "$src" --destination "$home" \
        --persistent-state "/tmp/state$(echo "$home" | tr / _).boltdb" --no-tty "$@" </dev/null
}

modes() { find "$1" -printf '%m %y %p -> %l\n' | sort; }

links_to() { [ -L "$1" ] && [ "$(readlink "$1")" = "$2" ]; }

# check_home <home> <deploy root>
check_home() {
    local h=$1 r=$2
    check "zshrc linked"           links_to "$h/.zshrc" "$r/.mine/shell/.zshrc"
    check "common_sh linked"       links_to "$h/.zshrc.d/00_common_sh" "$r/.mine/shell/common_sh"
    check "gitconfig linked"       links_to "$h/.gitconfig" "$r/.mine/git/.gitconfig"
    check "git.ignore linked"      links_to "$h/.git.ignore" "$r/.mine/git/.git.ignore"
    check "tmux.conf linked"       links_to "$h/.tmux.conf" "$r/.mine/tmux/.tmux.conf"
    check "emacs linked"           links_to "$h/.emacs" "$r/.mine/emacs/emacs-mj.el"
    if [ "$h" = "$r" ]; then
        check "oh-my-zsh installed" test -f "$h/.oh-my-zsh/oh-my-zsh.sh" -a ! -L "$h/.oh-my-zsh"
        check "no self-link inside oh-my-zsh" test ! -e "$h/.oh-my-zsh/.oh-my-zsh" -a ! -L "$h/.oh-my-zsh/.oh-my-zsh"
    else
        check "oh-my-zsh linked"   links_to "$h/.oh-my-zsh" "$r/.oh-my-zsh"
        check "oh-my-zsh installed" test -f "$r/.oh-my-zsh/oh-my-zsh.sh"
    fi
    check "tpm installed"          test -f "$r/.mine/tmux/tpm/tpm"
    check "bin on PATH"            grep -qF "export PATH=$r/.mine/bin:" "$h/.zshrc.d/10_mine_bin"
    check "bin executable"         bash -c "for f in '$r'/.mine/bin/*; do [ -x \"\$f\" ] || exit 1; done"
    for f in AGENTS.md CLAUDE.md .tests .claude; do
        check "$f not deployed"    test ! -e "$r/$f"
    done
}

with_umask() { local m=$1; shift; ( umask "$m"; "$@" ); }

# check_idempotent <home> <source>: second apply under another umask and a
# forced rerun of run_once scripts must change nothing.
check_idempotent() {
    local h=$1 s=$2 before
    before=$(modes "$h")
    check "verify clean after apply" cz "$h" "$s" verify --exclude=scripts
    check "reapply with umask 0007"  with_umask 0007 cz "$h" "$s" apply
    check "rerun run_once scripts"   cz "$h" "$s" state delete-bucket --bucket=scriptState
    check "apply after rerun"        cz "$h" "$s" apply
    check "no file or mode changes"  diff <(echo "$before") <(modes "$h")
}

# check_update <home> <deploy root> <source>: after zsh has filled the
# oh-my-zsh cache, chezmoi update twice under different umasks, refreshing
# externals, completes without prompts, keeps the cache and changes no file or mode.
check_update() {
    local h=$1 r=$2 s=$3 before
    mkdir -p "$r/.oh-my-zsh/cache"   # as left by installs before the cache was ignored
    check "zsh fills oh-my-zsh cache" in_zsh "$h" exit
    before=$(modes "$h")
    check "update with umask 0022"   with_umask 0022 cz "$h" "$s" update --refresh-externals=always
    check "update with umask 0007"   with_umask 0007 cz "$h" "$s" update --refresh-externals=always
    check "oh-my-zsh cache kept"     test -d "$r/.oh-my-zsh/cache/completions"
    check "no changes after update"  diff <(echo "$before") <(modes "$h")
}

# no_stderr <cmd...>: succeeds and writes nothing to stderr.
no_stderr() {
    local err
    err=$("$@" 2>&1 >/dev/null) || { echo "$err"; return 1; }
    [ -z "$err" ] || { echo "$err"; return 1; }
}

# in_zsh <home> <command>: interactive zsh in that home.
in_zsh() { env HOME="$1" XDG_CACHE_HOME="$1/.cache" zsh -i -c "$2"; }

# check_zsh <home>: run last, since zsh writes caches into the home.
check_zsh() {
    local h=$1 e=/tmp/home-empty-zshrcd
    check "zsh starts cleanly"       no_stderr in_zsh "$h" exit
    check "oh-my-zsh plugins loaded" in_zsh "$h" 'alias gst >/dev/null'
    mkdir -p "$e/.zshrc.d"
    ln -sfn "$(readlink -f "$h/.oh-my-zsh")" "$e/.oh-my-zsh"
    ln -sfn "$(readlink -f "$h/.zshrc")" "$e/.zshrc"
    check "zsh starts with empty .zshrc.d" no_stderr in_zsh "$e" exit
}

# --- personal repo from the snapshot ---------------------------------------
personal=/tmp/repos/personal
mkdir -p "$personal" && cp -a --no-preserve=ownership /snapshot/. "$personal"
git -C "$personal" init -q && git -C "$personal" add -A && git -C "$personal" commit -qm snapshot

echo "== standalone"
h=/tmp/home-standalone; mkdir -p "$h"
check "apply" cz "$h" "$personal" apply
check_home "$h" "$h"
check_idempotent "$h" "$personal"
check_zsh "$h"

echo "== standalone, existing file at a link path"
h=/tmp/home-seeded; mkdir -p "$h"; echo "keep me" > "$h/.tmux.conf"
check "apply" cz "$h" "$personal" apply
check "existing .tmux.conf kept" bash -c "[ ! -L '$h/.tmux.conf' ] && [ \"\$(cat '$h/.tmux.conf')\" = 'keep me' ]"

echo "== submodule"
consumer=/tmp/repos/consumer
mkdir -p "$consumer/home" && git -C "$consumer" init -q
echo home > "$consumer/.chezmoiroot"
git -C "$consumer" submodule -q add "$personal" home/dot_personal
git -C "$consumer" add -A && git -C "$consumer" commit -qm consumer
clone=/tmp/consumer-clone
git clone -q "$consumer" "$clone"
git -C "$clone" submodule -q update --init --recursive --checkout
check "submodule at recorded commit" test \
    "$(git -C "$clone/home/dot_personal" rev-parse HEAD)" = \
    "$(git -C "$clone" ls-tree HEAD home/dot_personal | awk '{print $3}')"
h=/tmp/home-submodule; mkdir -p "$h"
check "apply" cz "$h" "$clone" apply
check_home "$h" "$h/.personal"
check_idempotent "$h" "$clone"
check_update "$h" "$h/.personal" "$clone"
check_home "$h" "$h/.personal"

echo
if [ "$fails" -eq 0 ]; then echo "GREEN"; else echo "RED: $fails failed"; exit 1; fi
