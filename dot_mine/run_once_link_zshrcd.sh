#!/bin/bash

mkdir -p $HOME/.zshrc.d
ln -s $HOME/.mine/common_sh $HOME/.zshrc.d/00_common_sh

env > /tmp/env.log
