#!/bin/bash

clear

echo "  Changing to root..."
sudo su -

echo "  Updating system..."
apt-get update
apt-get upgrade -y

echo "  Essencial softwares..."
apt install -y --force-yes build-essential curl git zip unzip zsh vim tilix vlc

echo "Installing oh-my-zsh"
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo " Installing asdf..."
cd ~/  && git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.8

echo "  Ubuntu restrict extras..."
apt install -y --force-yes ubuntu-restricted-extras


echo " Installing docker..."
apt-get install -y --force-yes \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

apt-key fingerprint 0EBFCD88

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get update
apt install -y --force-yes docker-ce docker-ce-cli containerd.io
usermod -aG docker $USER


echo "Installing docker compose..."
curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

echo " Installing ctop..."
wget https://github.com/bcicen/ctop/releases/download/v0.7.3/ctop-0.7.3-linux-amd64 -O /usr/local/bin/ctop
chmod +x /usr/local/bin/ctop

echo " Installing fonts..."
apt install -y --force-yes fonts-hack-ttf fonts-powerline

echo "Installing dotfiles..."
curl -Lo install.sh https://raw.githubusercontent.com/paulocastellano/dotfiles/master/install.sh
sh install.sh

echo "Installing google chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
gdebi google-chrome-stable_current_amd64.deb

echo "Installing spotify..."
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
apt-get update && sudo apt-get install -y --force-yes spotify-client
