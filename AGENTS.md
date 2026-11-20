# dotfiles

chezmoi source directory for shell, git, tmux and emacs. chezmoi is not installed on the host; verify every change with `.tests/apply.sh`.

## Two deploy roots

The repo is applied in two ways, and every change must work in both:

- **Standalone**: chezmoi source root, deploys to `~`.
- **Submodule**: another chezmoi repo (with `.chezmoiroot` = `home`) mounts it at `home/dot_<name>/`, so everything deploys one level down, to `~/.<name>/`. That repo is not visible here; `.tests/` simulates it with the fake name `personal`.

Write paths relative to the deploy root, never as a literal `~/.mine/...`.

## Layout: deploy into .mine, then link into $HOME

Each tool owns `dot_mine/<tool>/`, deployed to `<root>/.mine/<tool>/`. A `run_once_*.sh` beside it symlinks the result into `$HOME` (`~/.tmux.conf -> <root>/.mine/tmux/.tmux.conf`). Shell snippets compose through `~/.zshrc.d/NN_name`, sourced in numeric order. `.chezmoiexternal.toml` externals also land under the deploy root; the root `run_once_home_links.sh` links `~/.oh-my-zsh` to them in submodule mode.

To add a tool: `dot_mine/<tool>/dot_<file>` plus `dot_mine/<tool>/run_once_links.sh`, copied from `dot_mine/tmux/`. Files that must be executable get the `executable_` prefix.

## Scripts

- chezmoi runs each script from its target directory, so `$PWD` is the deployed tool directory in either mode. Locate repo files through `$PWD`.
- Links go to `$HOME` directly, which chezmoi's `--destination` does not redirect; run real applies only in a disposable container home.
- Create a link only when its path is absent and leave an existing file untouched: use the `link` helper the scripts already carry.
- A `run_once_` script re-runs on every machine whenever its content changes, against a home that already has its links. The `link` helper makes that a no-op.
- `run_after_` scripts run on every apply.

## Repo-only files

Every source file whose name lacks a leading `.` is deployed, so a root file lands in `~` (or `~/.<name>/`). List repo-only files in `.chezmoiignore`; its patterns match target paths, not source names. Dot-directories like `.tests/` and `.claude/` are skipped automatically.

## Verify

`.tests/apply.sh` snapshots the working tree into a container and applies it standalone, with an existing file at a link path, and as a submodule of a fake consumer repo. It then checks links, executables and ignored files; that a second apply under a different umask, a forced rerun of `run_once` scripts and two `chezmoi update` runs change nothing; and that zsh starts without errors, with plugins loaded, even with an empty `.zshrc.d`. Done means it prints `GREEN`.

## Guardrails

- Secrets stay outside the repo: the GitHub token is read from `~/.github_token`, and the work git identity comes from an `includeIf` include. Reference them by path.
- Describe the consumer repo only in the generic terms above; keep its name, paths and employer out of this repo.
- `dot_mine/bin/executable_ack` (generated) and `dot_mine/emacs/template/` (vendored) change only by full replacement.
