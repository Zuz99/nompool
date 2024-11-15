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
sudo add-apt-repository -y ppa:bitcoin/bitcoin
sudo apt update
sudo apt install -y libdb4.8-dev libdb4.8++-dev libssl-dev libboost-all-dev libminiupnpc-dev libtool autotools-dev 
sudo apt install -y sudo git npm nodejs      

sudo systemctl enable fail2ban
sudo systemctl start fail2ban
sudo systemctl enable redis-server
sudo systemctl start redis-server
sudo systemctl enable ntp
sudo systemctl start ntp
sudo apt-get install build-essential tcl wget && wget -c http://download.redis.io/releases/redis-5.0.9.tar.gz && tar -xf redis-5.0.9.tar.gz && cd redis-5.0.9 && make && sudo make install && cd utils/ && sudo ./install_server.sh
sudo rm -rf ~/.nvm
sudo rm -rf ~/.npm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
source ~/.bashrc
sudo chown -R $USER:$GROUP ~/.nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install v12.22.7.0
nvm use v12.22.7
npm update -g

npm install -g webpack@4.46.0
npm install -g pm2@4.5.6


npm install
npm update
npm audit fix
npm install sha3
npm install logger

echo "Installation completed!"

exit 0
