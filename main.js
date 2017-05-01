const Web3 = require('web3');
const solc = require('solc');
const fs = require('fs');

var web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
let account = "0x2a50613a76a4c2c58d052d5ebf3b03ed3227eae9";

let count = parseInt(20);

let source = fs.readFileSync('simple-storage.sol', 'utf8');
let compiledContract = solc.compile(source);
let abi = compiledContract.contracts[':SimpleStorage'].interface;
let bytecode = compiledContract.contracts[':SimpleStorage'].bytecode;
let gasEstimate = web3.eth.estimateGas({data: "0x" + bytecode});
let MyContract = web3.eth.contract(JSON.parse(abi));
web3.personal.unlockAccount(account, "test");
if (account.indexOf('0x') !== 0) {
    account = '0x' + account;}

var myContractFunction = function(n) {
    
    MyContract.new({
        from: account,
        data: "0x" + bytecode,
        gas: gasEstimate + n
    }, function (err, myContract) {
        if (err) {
            console.log(err);
        } else {
            if (!myContract.address) {
                var h = myContract.transactionHash;
                var tx = web3.eth.getTransaction(h);
                console.log(h+":" +tx)

            }
        }
    });
}



var loadNode = function(){
    for(var i =0; i < count; i++){
        myContractFunction(i);
    }
}
loadNode();
