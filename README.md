## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### 
```
#for MacOS
brew install libusb

curl -L https://foundry.paradigm.xyz | bash

#for MacOS
source ~/.zshrc 

foundryup
```
### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```

## Helper script
Define env variables
```
PRIVATE_KEY=your_private_key
```
### To create loan
```
source .env
forge script script/CreateLoan.s.sol:CreateLoanScript --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY --broadcast --env LOAN_CONTRACT_ADDRESS=0xe58797710aebd14f4420fce7739d61a6ab06cbad --env BORROWER_ADDRESS=0xborrowerAddress --env LOAN_AMOUNT=1000000000000000000
```
