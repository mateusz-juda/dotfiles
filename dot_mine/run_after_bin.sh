#!/bin/bash

chmod a+x $PWD/bin/*

mkdir -p $HOME/.zshrc.d

cat -<<EOF > $HOME/.zshrc.d/10_mine_bin
export PATH=$PWD/bin:\$PATH
EOF
