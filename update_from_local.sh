#!/bin/bash
# Script copies all local files and updates the current folder

cp ~/.vimrc .vimrc || echo "no vimrc"
cp ~/.tmux.conf .tmux.conf || echo "no tmux.conf"
cp ~/.bashrc .bashrc || echo "no bashrc"
cp ~/Programming/lib/global_gitignore .gitignore || echo "no global_gitignore"
cp ~/.Xdefaults .Xdefaults || echo "no xdefaults"
cp ~/.Xmodremap .Xmodremap || echo "no xmodremap"
cp ~/.zprofile .zprofile || echo "no zprofile"
cp ~/.zshrc .zshrc || echo "no zshrc"
cp -r ~/.vim/colors .vim/colors || echo "no .vim/colors"
cp -r ~/.vim/spell .vim/ || echo "no .vim/spell"
mkdir -p .config/nvim/
cp ~/.config/nvim/coc-settings.json .config/nvim/coc-settings.json || echo "no coc-settings.json"

