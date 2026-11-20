#!/bin/bash

# Create link $2 -> $1 only when $2 is absent; an existing file is never replaced.
link() {
    [ "$1" = "$2" ] && return 0
    if [ -e "$2" ] || [ -L "$2" ]; then
        [ "$(readlink "$2")" = "$1" ] || echo "skip: $2 already exists" >&2
        return 0
    fi
    ln -s "$1" "$2"
}

link "$PWD/.oh-my-zsh" "$HOME/.oh-my-zsh"
