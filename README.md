### How to use

At first, we need to get testnet blockchain either long way via graftnoded sync or much faster with fresh snapshot.

Let's make it quick (thanks Jason aka @jagerman42 for this):

```
mkdir -p $HOME/.graft/testnet/lmdb
wget https://rta.graft.observer/lmdb/data.mdb -P $HOME/.graft/testnet/lmdb/
docker run --name graft -d -v $HOME/.graft:/root/.graft -p 28690:28690 mustdie95/graft:alpha3  

```
or

If link doesn't work - use alternative as Dropbox (thanks Tiago aka @el_duderino_007):

```
mkdir $HOME/.graft
wget "https://www.dropbox.com/s/b55s59bluvp8s1z/graft_bc_testnet_bkp_17Nov18.zip" -P /tmp
unzip /tmp/graft_bc_testnet_bkp_17Nov18.zip '.graft/testnet/*' -d $HOME/
docker run --name graft -d -v $HOME/.graft:/root/.graft -p 28690:28690 mustdie95/graft:alpha3  

```  
Both shellcode sequences will download blockchain snapshot and run docker container with supervisor & graftnoded.  

Let's run interactive shell in our container and look into graftnoded log file:  

```
docker exec -ti graft /bin/bash 
tail -f -n 100 /$HOME/.graft/testnet/graft.log

```  
Then follow insructions from "Configuration of Alpha RTA Environment" step (note that default config.ini is already in /opt directory).

$HOME/.graft directory on your host will be used to store blockchain data & wallets. 
It is preserved after container was stopped
