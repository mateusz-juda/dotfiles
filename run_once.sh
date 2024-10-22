#!/bin/bash

mkdir -p $PWD/.zshrc.d

if [ "$PWD" != "$HOME" ]; then
    ln -s $PWD/.zshrc.d $HOME/.zshrc.d
    ln -s $PWD/.zshrc $HOME/.zshrc
fi
