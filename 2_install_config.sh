#!/bin/bash

# Adding all config into home

cp .* ~/
cp -r .vim ~/
cp -r .config ~/
rm ~/.gitignore

echo "Done"

