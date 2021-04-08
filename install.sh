#!/bin/bash

clear

echo "  Changing to root..."
sudo su -

echo "  Updating system..."
apt-get update
apt-get upgrade -y

echo "  Essencial softwares..."
apt install -y --force-yes build-essential curl git rar zip unzip vim tilix vlc ffmpeg ffmpegthumbnailer neofetch

echo "  Ubuntu restrict extras..."
apt install -y --force-yes ubuntu-restricted-extras

echo "Installing snap..."
apt install -y --force-yes snapd

echo "Installing Vscode..."
snap install -y --force-yes --classic code

echo "Installing Insomnia..."
snap install -y --force-yes --classic insomnia

echo "Installing Discord..."
snap install -y --force-yes discord --classic

echo "Installing oh-my-zsh"
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing oh-my-zsh >> zsh-autosuggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "Installing oh-my-zsh >> zsh-syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

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

echo "Installing google chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
gdebi google-chrome-stable_current_amd64.deb

echo "Installing spotify..."
curl -sS https://download.spotify.com/debian/pubkey.gpg | apt-key add -
echo "deb http://repository.spotify.com stable non-free" | tee /etc/apt/sources.list.d/spotify.list
apt-get update && apt-get install -y --force-yes spotify-client

echo "Installing NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
