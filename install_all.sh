
# Installing dependencies
sudo apt install git -y
sudo apt install curl -y
sudo apt install ubuntu-restricted-extras


# Installing NVIDIA card
#### Run apt update
#### Install from softawre menu to install nvidia-390 driver
# Download cuda driver: 
curl -O https://developer.nvidia.com/compute/cuda/9.2/Prod2/local_installers/cuda_9.2.148_396.37_linux
chmod +x cuda_9.2.148_396.37_linux
./cuda_9.2.148_396.37_linux --extract=$HOME


# Installing anaconda
### Download 
curl -O https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh
bash Anaconda3-5.2*

# Install VIM
## Remove previous configurations of vim
sudo apt remove -y vim vim-runtime gvim vim-tiny vim-common vim-gui-common vim-nox

## Install dependencies
sudo apt install libncurses5-dev libgnome2-dev libgnomeui-dev \
libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
python3-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev git

## clone the git repo
git clone https://github.com/vim/vim.git

## Then run the configure command with the right params

./configure \
--enable-multibyte \
--enable-rubyinterp=dynamic \
--with-ruby-command=/usr/bin/ruby \
--enable-pythoninterp=dynamic \
--with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
--enable-cscope \
--enable-gui=auto \
--with-features=huge \
--with-x \
--enable-fontset \
--enable-largefile \
--enable-fail-if-missing
## Then run make with runtime vim dir
make VIMRUNTIMEDIR=/usr/local/share/vim/vim81

## Finally install with checkinstall
sudo apt install checkinstall -y
sudo checkinstall


# Install geeknote
## clone variation of github
git clone https://github.com/jeffkowalski/geeknote 
cd geeknote
## Install with python
sudo python2.7 setup.py install
pip2 install bs4 html2text markdown markdown2 sqlalchemy evernote lxml thrift proxyenv 

## Login with geeknote
geeknote login
## Enter credential ^




# Install node
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
nvm install node
nvm alias default node

# Install zsh
sudo apt install zsh
sudo chsh -s `which zsh` alejandro

# Oh my zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

## Powerline 9k theme
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

## Install powerline fonts
curl -O https://github.com/powerline/fonts/blob/master/Meslo%20Slashed/Meslo%20LG%20M%20Regular%20for%20Powerline.ttf?raw=true
xdg-open Meslo*

# Installing apps
sudo apt install autokey-gtk -y
sudo apt install chromium-browser -y

# Adding config
git clone https://github.com/axsauze/alejandro-profile-config
cd alejandro-profile-config
cp .* ~/




# Misc install
### Firefox
### Install chromium
### OnePass Extension

