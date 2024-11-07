#!/bin/sh

# This is the Pool install script.
echo "Pool install script."
echo "Please do NOT run as root, run as the pool user!"

echo "Installing... Please wait!"

sleep 3

sudo rm -rf /usr/lib/node_modules
sudo rm -rf node_modules
sudo apt remove --purge -y nodejs node
sudo rm /etc/apt/sources.list.d/*
sudo apt update
sudo apt upgrade -y
sudo apt dist-upgrade -y
sudo apt install -y apt-transport-https software-properties-common build-essential autoconf pkg-config make gcc g++ screen wget curl ntp fail2ban 

#sudo add-apt-repository -y ppa:chris-lea/redis-server
sudo add-apt-repository ppa:luke-jr/bitcoincore
sudo add-apt-repository -y ppa:bitcoin/bitcoin

sudo apt update
sudo apt install -y  libcap2-bin libdb4.8-dev libdb4.8++-dev libdb5.3-dev libdb5.3++-dev libssl-dev libboost-all-dev libminiupnpc-dev libtool autotools-dev redis-tools redis-server libgmp3-dev
sudo apt install -y sudo git npm nodejs      

sudo systemctl enable fail2ban
sudo systemctl start fail2ban
sudo systemctl enable redis-server
sudo systemctl start redis-server
sudo systemctl enable ntp
sudo systemctl start ntp
sudo setcap cap_net_bind_service=+ep `readlink -f \`which node\``
sudo rm -rf ~/.nvm
sudo rm -rf ~/.npm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.bashrc

sudo chown -R $USER:$GROUP ~/.nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install v12.22.12
nvm use v12.22.12
git config --global url.https://github.com/.insteadOf git://github.com/
npm update -g

npm install -g webpack@latest
npm install -g pm2@4
npm install -g npm@6

npm install
npm update
npm audit fix
npm install sha3
npm install logger
source ~/.bashrc
echo "Installation completed!"

exit 0
