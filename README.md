
How to use:
1) mkdir $HOME/.graft
2) wget "https://www.dropbox.com/s/1xpwswxj780ugpq/graft_testnet_bc_bkp_15Nov18.zip" -P /tmp
3) unzip /tmp/graft_testnet_bc_bkp_12Nov18.zip '.graft/testnet/*' -d $HOME/
2) docker run --name graft -d -v $HOME/.graft:/root/.graft -p 28690:28690 mustdie95/graft:alpha3
This will download blockchain snapshot and run docker container with supervisor & graftnoded.

Let's run interactive shell in our container and look into graftnoded log file:
4) docker exec -ti graft /bin/bash
5) tail -f -n 100 /$HOME/.graft/testnet/graft.log

Then follow insructions from "Configuration of Alpha RTA Environment" step (note that default config.ini is already in /opt directory).

$HOME/.graft directory on your host will be used to store blockchain data & wallets.
It is preserved after container was stopped.
