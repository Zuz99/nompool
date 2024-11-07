# NOMP Pool
Highly Efficient mining pool !
Update <b> Nov 2024 OS: Ubuntu 18+/20+</b>

-------
### Screenshots
#### Home<br />
![Home](https://raw.githubusercontent.com/Satoex/kawpow-pool/master/docs/frontend/home.png)

#### Pool Stats<br />
![Pool Stats](https://raw.githubusercontent.com/Satoex/kawpow-pool/master/docs/frontend/poolstats.png)<br /><br />

#### Miner Stats<br />
![Miner Stats](https://raw.githubusercontent.com/Zuz99/kawpow-pool/master/docs/frontend/minerstats.png)<br /><br />

#### Payments<br />
![Payments](https://raw.githubusercontent.com/Zuz99/kawpow-pool/master/docs/frontend/payments.png)<br /><br />

-------
### Node Open Mining Portal consists of 3 main modules:
| Project | Link |
| ------------- | ------------- |
| [KawPoWNOMP](https://github.com/Satoex/kawpow-pool) | https://github.com/Satoex/kawpow-pool|
| [Stratum Pool](https://github.com/digvpn/stratum-pool-zone) | https://github.com/digvpn/stratum-pool-zone |
| [Node Multihashing](https://github.com/digvpn/node-multi-hashing) | https://github.com/digvpn/node-multi-hashing |

-------
### Requirements
***NOTE:*** _These requirements will be installed in the install section!_<br />
* Ubuntu Server 18.04.* LTS / 20.*
* Coin daemon
* Node Version Manager
* Node 12.22.12
* Process Manager 2 / pm2
* Redis Server
* ntp

-------

### Install RavenCoin Daemon

    adduser pool
    usermod -aG sudo pool
    su - pool
    sudo apt install wget
    wget https://github.com/RavenProject/Ravencoin/releases/download/v4.3.1/raven-4.3.1.0-x86_64-linux-gnu.tar.gz
    tar -xf raven-4.3.1.0-x86_64-linux-gnu.tar.gz
    rm raven*gz
    cd raven-4.3.1.0/bin
    mkdir -p ~/.raven/
    touch ~/.raven/raven.conf
    echo "rpcuser=user1" > ~/.raven/raven.conf
    echo "rpcpassword=pass1" >> ~/.raven/raven.conf
    echo "prune=550" >> ~/.raven/raven.conf
    echo "daemon=1" >> ~/.raven/raven.conf
    ./ravend
    ./raven-cli getnewaddress

Example output: RNs3ne88DoNEnXFTqUrj6zrYejeQpcj4jk - it is the address of your pool, you need to remember it and specify it in the configuration file pool_configs/ravencoin.json.
    
    ./raven-cli getaddressesbyaccount ""
    
Information about pool wallet address.
    
    ./raven-cli getwalletinfo
    
Get more information.

    ./raven-cli getblockcount
    
Information about synchronization of blocks in the main chain.

    ./raven-cli help
Other helpfull commands.

-------

### Install Pool

    sudo apt install git -y
    cd ~
    git config --global http.https://gopkg.in.followRedirects true
    git clone https://github.com/Zuz99/nompool.git
    cd nompool/
    bash install.sh

-------
### Configure Pool

Change "stratumHost": "192.168.1.100", to your IP or DNS in file config.json:

    cd ~/nompool
    nano config.json

```javascript
{
    
    "poolname": "nompool",
    
    "devmode": false,
    "devmodePayMinimim": 0.25,
    "devmodePayInterval": 120,
    
    "logips": true,       
    "anonymizeips": true,
    "ipv4bits": 16,
    "ipv6bits": 16,
    
     "defaultCoin": "ravencoin",
    
    "poollogo": "https://zelcash.github.io/zeltrez.io/images/logos/Ravencoin.svg",
    
    "discordtwitterfacebook": "Join our #mining channel on Discord: <a href='https://discord.gg/vzcbVNW' target='_blank'>https://discord.gg/vzcbVNW</a>",
    
    "pagetitle": "KawPoW Algorithm Pool - 0.5% Fees Promo - Run by professionals",
    "pageauthor": "My Name Is...",
    "pagedesc": "A reliable, low fee, easy to use mining pool for KawPoW algorithm coins! Get started mining today!",
    "pagekeywds": "GPU,CPU,Hash,Hashrate,Cryptocurrency,Crypto,Mining,Pool,Ravencoin,Zelantus,Sato,Easy,Simple,How,To",

    "btcdonations": "bc1qcj77e34nhts83a8ttyrr2d7y7p00avgd53yd5l",
 

    "logger" : {
        "level" : "debug",
        "file" : "/home/pool/nompool/logs/nomp_debug.log"
    },

    "cliHost": "127.0.0.1",
    "cliPort": 17117,

    "clustering": {
        "enabled": false,
        "forks": "auto"
    },

    "defaultPoolConfigs": {
        "blockRefreshInterval": 400,
        "jobRebroadcastTimeout": 30,
        "connectionTimeout": 600,
        "emitInvalidBlockHashes": false,
        "validateWorkerUsername": true,
        "tcpProxyProtocol": false,
        "banning": {
            "enabled": true,
            "time": 600,
            "invalidPercent": 50,
            "checkThreshold": 500,
            "purgeInterval": 300
        },
        "redis": {
            "host": "127.0.0.1",
            "port": 6379
        }
    },

    "website": {
        "enabled": true,
        "sslenabled": false,
        "sslforced": false,
        "host": "0.0.0.0",
        "port": 80,
        "sslport": 443,
        "sslkey": "/home/pool/nompool/certs/privkey.pem",
        "sslcert": "/home/pool/nompool/certs/fullchain.pem",
        "stratumHost": "192.168.0.200",
        "stats": {
            "updateInterval": 15,
            "historicalRetention": 28800,
            "hashrateWindow": 600
        },
        "adminCenter": {
            "enabled": false,
            "password": "NOT_WORKING_YET"
        }
    },

    "redis": {
        "host": "127.0.0.1",
        "port": 6379
    },

    "switching": {
        "switch1": {
            "enabled": false,
            "algorithm": "sha256",
            "ports": {
                "3333": {
                    "diff": 10,
                    "varDiff": {
                        "minDiff": 16,
                        "maxDiff": 512,
                        "targetTime": 15,
                        "retargetTime": 90,
                        "variancePercent": 30
                    }
                }
            }
        },
        "switch2": {
            "enabled": false,
            "algorithm": "scrypt",
            "ports": {
                "4444": {
                    "diff": 10,
                    "varDiff": {
                        "minDiff": 16,
                        "maxDiff": 512,
                        "targetTime": 15,
                        "retargetTime": 90,
                        "variancePercent": 30
                    }
                }
            }
        },
        "switch3": {
            "enabled": false,
            "algorithm": "x11",
            "ports": {
                "5555": {
                    "diff": 0.001,
                    "varDiff": {
                        "minDiff": 0.001,
                        "maxDiff": 1, 
                        "targetTime": 15, 
                        "retargetTime": 60, 
                        "variancePercent": 30 
                    }
                }
            }
        }
    },

    "profitSwitch": {
        "enabled": false,
        "updateInterval": 600,
        "depth": 0.90,
        "usePoloniex": true,
        "useCryptsy": true,
        "useMintpal": true,
        "useBittrex": true
    }

}

```

Change "address": "RNs3ne88DoNEnXFTqUrj6zrYejeQpcj4jk", to your pool created wallet address in file ravencoin.json:

    cd ~/nompool/pool_configs
    nano ravencoin.json

```javascript
{
    "enabled": true,
    "coin": "ravencoin.json",

    "address": "RNs3ne88DoNEnXFTqUrj6zrYejeQpcj4jk",
    
    "donateaddress": "RNs3ne88DoNEnXFTqUrj6zrYejeQpcj4jk",

    "rewardRecipients": {
        "RNs3ne88DoNEnXFTqUrj6zrYejeQpcj4jk": 0.5
    },

    "paymentProcessing": {
        "enabled": true,
        "schema": "PROP",
        "paymentInterval": 300,
        "minimumPayment": 1,
        "maxBlocksPerPayment": 10,
        "minConf": 30,
        "coinPrecision": 8,
        "daemon": {
            "host": "127.0.0.1",
            "port": 8766,
            "user": "user1",
            "password": "pass1"
        }
    },

    "ports": {
	"10008": {
            "diff": 0.05,
    	    "varDiff": {
    	        "minDiff": 0.025,
    	        "maxDiff": 1024,
    	        "targetTime": 10,
    	        "retargetTime": 60,
    	        "variancePercent": 30,
    		"maxJump": 25
    	    }
        },
        "10016": {
	    "diff": 0.10,
            "varDiff": {
                "minDiff": 0.05,
                "maxDiff": 1024,
    	        "targetTime": 10,
    	        "retargetTime": 60,
    	        "variancePercent": 30,
		"maxJump": 25
            }
        },
        "10032": {
	    "diff": 0.20,
            "varDiff": {
    		"minDiff": 0.10,
    		"maxDiff": 1024,
    	        "targetTime": 10,
    	        "retargetTime": 60,
    	        "variancePercent": 30,
    		"maxJump": 50
    	    }
        },
	"10256": {
	    "diff": 1024000000,
            "varDiff": {
                "minDiff": 1024000000,
                "maxDiff": 20480000000,
    	        "targetTime": 10,
    	        "retargetTime": 60,
    	        "variancePercent": 30,
		"maxJump": 25
            }
        }
    },

    "daemons": [
        {
            "host": "127.0.0.1",
            "port": 8766,
            "user": "user1",
            "password": "pass1"
        }
    ],

    "p2p": {
        "enabled": false,
        "host": "127.0.0.1",
        "port": 8767,
        "disableTransactions": true
    },

    "mposMode": {
        "enabled": false,
        "host": "127.0.0.1",
        "port": 3306,
        "user": "me",
        "password": "mypass",
        "database": "rvn",
        "checkPassword": true,
        "autoCreateWorker": false
    },

    "mongoMode": {
        "enabled": false,
        "host": "127.0.0.1",
        "user": "",
        "pass": "",
        "database": "rvn",
        "authMechanism": "DEFAULT"
    }

}

```

### Run Pool
    
    cd ~/nompool
    node init.js

### Donates for developers KawPoWNOMP


BTC: bc1qcj77e34nhts83a8ttyrr2d7y7p00avgd53yd5l
-------
### Creidt:
| ------------- | ------------- |
| [Zone117x(https://github.com/zone117x) | https://github.com/zone117x/stratum-pool|
| [EasyX-Community](https://github.com/EasyX-Community) | https://github.com/EasyX-Community/ |
| [Node Multihashing](https://github.com/digvpn/node-multi-hashing) | https://github.com/digvpn/node-multi-hashing |

-------
