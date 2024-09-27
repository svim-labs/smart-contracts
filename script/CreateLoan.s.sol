// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "lib/forge-std/src/Script.sol";
import {ILoanType, ILoanSettings} from "../src/interfaces/ILoan.sol";

interface ILoanFactory {
    function createLoan(
        address borrower,
        address pool,
        address liquidityAsset,
        ILoanSettings memory settings
    ) external returns (address);
}

contract CreateLoanScript is Script {
    function run(address borrower, address pool) external {
        ILoanFactory loanContract = ILoanFactory(0xe58797710Aebd14F4420Fce7739D61A6aB06cbad);
        address liquidityAsset = 0xa0058dc18D7810Cc91E788b4e9622370f6075576;
        ILoanSettings memory setting = ILoanSettings(
            ILoanType.Fixed, 10 ether, 1000, 30, 30, 1735094810, 1000, 100
        );

        vm.startBroadcast();

        loanContract.createLoan(borrower, pool, liquidityAsset, setting);

        vm.stopBroadcast();
    }
}
