#!/bin/bash

if [ "$EUID" -ne 0 ]
    then echo "Please run as root"
    exit
fi

sudo apt update -y
sudo apt upgrade -y

# Installign dependencies
sudo apt install -y git curl build-essential cmake python-dev python3-dev

# Working from personal laptop so cache git password
git config --global user.name "Alejandro Saucedo"
git config --global user.email "axsauze@gmail.com"
git config --global credential.helper store

# Install node
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install node
nvm alias default node

# Install zsh
sudo apt install zsh -y
sudo chsh -s `which zsh` alejandro

# Install Oh my zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh 
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k 

# Installing silver surfer and zsh
sudo apt install silversearcher-ag -y
# ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb 
sudo dpkg -i ripgrep_0.10.0_amd64.deb 
# fzf (This will ask for options)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf 
yes | ~/.fzf/install


# Adding all config into home
cp .* ~/
cp -r .vim ~/
cp -r .config ~/
rm ~/.gitignore

# Install all vim pluggins
vim +'PlugInstall --sync' +qa
# Compile YCM
cd ~/.vim/plugged/YouCompleteMe 
python3 install.py


# Install tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
source ~/.tmux.conf
~/.tmux/plugins/tpm/scripts/install_plugins.sh

# CHanging ownership for all users created under root
sudo chown -R alejandro:alejandro ~ 

