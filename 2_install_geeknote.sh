#!/bin/bash

# Removing vim and all depdencies
sudo apt remove -y vim vim-runtime gvim vim-tiny vim-common vim-gui-common vim-nox 

# Installing all dependencies
sudo apt install libncurses5-dev libgnome2-dev libgnomeui-dev \
libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
python3-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev git  -y

# Installing vim from source
git clone https://github.com/vim/vim.git
cd vim

./configure \
	--enable-multibyte \
	--enable-rubyinterp=dynamic \
	--with-ruby-command=/usr/bin/ruby \
	--enable-pythoninterp=dynamic \
	--with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
	--enable-cscope \
	--enable-gui=auto \
	--with-features=huge \
	--enable-fontset \
	--enable-largefile \
	--enable-fail-if-missing \
#	--with-x \  # Enable this if not on wsl

make VIMRUNTIMEDIR=/usr/local/share/vim/vim81 

sudo apt install checkinstall -y
sudo checkinstall

cd ..
rm -rf vim

# Installing geeknote
git clone https://github.com/jeffkowalski/geeknote 
cd geeknote
sudo python2.7 setup.py install
pip2 install bs4 html2text markdown markdown2 sqlalchemy evernote lxml thrift proxyenv 

# CHanging ownership for all users created under root
sudo chown -R alejandro:alejandro ~ 

geeknote login


