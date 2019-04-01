#!/bin/bash

export USER=alejandro

sudo apt install -y git curl 

# Install node
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install node
nvm alias default node


# Install zsh
sudo apt install zsh -y
sudo chsh -s `which zsh` $USER

# Install Oh my zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh 
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k 

# Installing silver surfer and zsh
sudo apt install silversearcher-ag -y
# ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb 
sudo dpkg -i ripgrep_0.10.0_amd64.deb 
# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf 
~/.fzf/install


