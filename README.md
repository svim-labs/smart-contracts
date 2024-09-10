## This repo is not the production repo of the Svim Finance dAPP, but is a mirror of the entire architecture of it's smart contracts (excluding the scriptes of deployment, operations and bots...etc.) for open source purposes.

**For questions, please contact @dev Sean -- sean.xu@svim.io**

-----------------------------------------------

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
PRIVATE_KEY=your_private_key #THIS IS SENSITIVE INFO
SEPOLIA_RPC_URL=https://eth-sepolia.g.alchemy.com/v2/<ALCHEMY API KEY>
```
### To create loan
Because Create Loan cannot be handled in etherscan, so we can only run locally
```
source .env
forge script scripts/CreateLoan.s.sol:CreateLoanScript --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY --broadcast --sig "run(address,address)" <YOUR WALLET ADDRESS> <POOL ADDRESS>
```
