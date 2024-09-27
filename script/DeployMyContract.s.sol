   // SPDX-License-Identifier: UNLICENSED
   pragma solidity ^0.8.13;

   import "forge-std/Script.sol";
   import {Pool} from "../src/Pool.sol";

   contract DeployMyContract is Script {
       function run() external {
           string memory privateKeyHex = vm.envString("PRIVATE_KEY");
           uint256 deployerPrivateKey = vm.parseUint(string.concat("0x", privateKeyHex));
           vm.startBroadcast(deployerPrivateKey);

           Pool pool = new Pool();

           vm.stopBroadcast();
       }
   }