#!/bin/bash


# Installing geeknote
git clone https://github.com/jeffkowalski/geeknote 
cd geeknote
sudo python2.7 setup.py install
pip2 install bs4 html2text markdown markdown2 sqlalchemy evernote lxml thrift proxyenv 

# CHanging ownership for all users created under root
sudo chown -R alejandro:alejandro ~ 

geeknote login


