GETH=/home/martin/workspace/go-ethereum/build/bin/geth
rm -rf ./A

echo '
{
  "nonce":      "0x0000000000000000",
  "difficulty": "0x1",
  "mixhash":    "0x0000000000000000000000000000000000000000000000000000000000000000",
  "coinbase":   "0x0000000000000000000000000000000000000000",
  "timestamp":  "0x00",
  "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
  "extraData":  "0x0000000000000000000000000000000000000000000000000000000000000000",
  "gasLimit":   "0x3D0900",
  "alloc": {
    "0x2a50613a76a4c2c58d052d5ebf3b03ed3227eae9" :{ "balance": "1000000000000000000000000"}
  },
    "config": {
            "homesteadBlock": 10
    }
}
' > genesis.json


$GETH --datadir ./A init genesis.json

cp 0x2a50613a76a4c2c58d052d5ebf3b03ed3227eae9.json ./A/keystore/

echo bdfb0a13376c7fe62a7be90830c22ee3b16fee8fcf390bb0b6a662f2f65082a1 > ./A/geth/nodekey

$GETH --rpc --rpcapi web3,personal,eth --datadir ./A --etherbase 0x0000000000000000000000000000000000000006 --port 30001 --networkid 314 --maxpeers=2 --etherbase 0x2a50613a76a4c2c58d052d5ebf3b03ed3227eae9 #2> A.log &

#sleep 10 # Wait for nodes to conenct (mining screwes crypto handshakes)

#tail -f A.log
#killall geth
