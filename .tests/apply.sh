#!/bin/bash
# Apply this working tree in a throwaway container, standalone and as a
# submodule of a fake consumer repo, once per chezmoi version.
# CHEZMOI_VERSIONS overrides the list; "image" is the image's own chezmoi.
# Done means the last line is ALL GREEN.
set -euo pipefail

repo=$(cd "$(dirname "$0")/.." && pwd)
image=chezmoi-test
versions=${CHEZMOI_VERSIONS:-2.57.0 image}

docker build -q -t "$image" "$repo/dot_dotfiles_internal/docker-test" >/dev/null

snap=$(mktemp -d)
trap 'rm -rf "$snap"' EXIT

# Snapshot tracked and untracked (not git-ignored) files as they are on disk.
(cd "$repo" && git ls-files -z -co --exclude-standard |
    while IFS= read -r -d '' f; do [ -e "$f" ] && printf '%s\0' "$f"; done |
    tar --null -T - -cf -) | tar -xf - -C "$snap"

red=""
for v in $versions; do
    docker run --rm -e CHEZMOI_VERSION="$v" -v "$snap:/snapshot:ro" "$image" \
        bash /snapshot/.tests/in-container.sh || red="$red $v"
done

echo
if [ -z "$red" ]; then echo "ALL GREEN"; else echo "RED on:$red"; exit 1; fi
