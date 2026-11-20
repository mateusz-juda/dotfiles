#!/bin/bash
# Apply this working tree in a throwaway container, standalone and as a
# submodule of a fake consumer repo. Exit 0 means green.
set -euo pipefail

repo=$(cd "$(dirname "$0")/.." && pwd)
image=chezmoi-test

docker build -q -t "$image" "$repo/dot_dotfiles_internal/docker-test" >/dev/null

snap=$(mktemp -d)
trap 'rm -rf "$snap"' EXIT

# Snapshot tracked and untracked (not git-ignored) files as they are on disk.
(cd "$repo" && git ls-files -z -co --exclude-standard |
    while IFS= read -r -d '' f; do [ -e "$f" ] && printf '%s\0' "$f"; done |
    tar --null -T - -cf -) | tar -xf - -C "$snap"

docker run --rm -v "$snap:/snapshot:ro" "$image" bash /snapshot/.tests/in-container.sh
