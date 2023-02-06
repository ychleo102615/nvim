#!/bin/bash
mkdir -p ~/lazy/.config/nvim ~/lazy/.local/share/ ~/lazy/.local/state/
git clone https://github.com/LazyVim/starter ~/lazy/.config/nvim
# alias this line
XDG_CONFIG_HOME=~/lazy/.config XDG_DATA_HOME=~/lazy/.local/share/ XDG_STATE_HOME=~/lazy/.local/state nvim
