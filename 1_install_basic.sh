#!/bin/bash

if [ "$EUID" -ne 0 ]
    then echo "Please run as root"
    exit
fi

uname 002

mkdir Programming
mkdir Programming/bin
mkdir Programming/lib

sudo apt update -y
sudo apt upgrade -y

# Installign dependencies
sudo apt install -y git curl build-essential cmake python-dev python3-dev python-pip python3-pip jq
pip2 install neovim black
pip3 install neovim black

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

# Install oh my zsh plugins
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $ZSH_CUSTOM/plugins/you-should-use
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

# Installing silver surfer and zsh
sudo apt install silversearcher-ag -y
# ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb 
sudo dpkg -i ripgrep_0.10.0_amd64.deb 
# fzf (This will ask for options)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf 
yes | ~/.fzf/install

#Install miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
# Using -b and -p to install without interactvive
./Miniconda3-latest-Linux-x86_64.sh  -b -p $HOME/miniconda

# INSTALLING VIM
# Removing vim and all depdencies
sudo apt remove -y vim vim-runtime gvim vim-tiny vim-common vim-gui-common vim-nox 
# Install neovim with python support
sudo apt-get -y install neovim python-neovim python3-neovim

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


# Install kubernetes (FOR WSL)
# As per https://devkimchi.com/2018/06/05/running-kubernetes-on-wsl/
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl 
chmod +x ./kubectl 
mv ./kubectl ~/Programming/bin

# Install jenkins x
curl -L "https://github.com/jenkins-x/jx/releases/download/$(curl --silent https://api.github.com/repos/jenkins-x/jx/releases/latest | jq -r '.tag_name')/jx-linux-amd64.tar.gz" | tar xzv "jx"

### INSTALL HELM
wget https://storage.googleapis.com/kubernetes-helm/helm-v2.5.0-linux-amd64.tar.gz
tar -zxvf helm-v2.5.0-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin


###################################################
# OPTIONAL: CONFIGURE KUBECTL AND DOCKER
# This should be configured depending on whether you path starts with /c/ or /mnt
mkdir ~/.kube \
&& cp /mnt/c/Users/[USERNAME]/.kube/config ~/.kube

# Ensure that Kubectl uses the docker-for-desktop context
kubectl config use-context docker-for-desktop




