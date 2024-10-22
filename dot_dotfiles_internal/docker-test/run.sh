#!/bin/bash

WD="/Users/me/work/mine/"
echo "Run: chezmoi init --guess-repo-url=false $WD/dotfiles && chezmoi apply"
docker run -ti -v $WD:$WD -w /tmp/home -u $(id -u):$(id -g) chezmoi-test



