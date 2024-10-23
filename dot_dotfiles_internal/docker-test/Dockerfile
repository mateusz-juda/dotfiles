FROM ubuntu:24.04

RUN apt-get -yy update && apt-get install -yy nano less curl git emacs zsh tmux

RUN sh -c "$(curl -fsLS get.chezmoi.io)"
RUN git config --system protocol.file.allow always
RUN mkdir /tmp/home && chmod a+rwx /tmp/home
ENV HOME=/tmp/home

