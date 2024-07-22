// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "forge-std/Script.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface ILoanContract {
    function createLoan(address borrower, uint256 amount) external;
}

contract CreateLoanScript is Script {
    function run() external {
        address loanContractAddress = vm.envAddress("LOAN_CONTRACT_ADDRESS");
        address borrowerAddress = vm.envAddress("BORROWER_ADDRESS");
        uint256 loanAmount = vm.envUint("LOAN_AMOUNT");

        ILoanContract loanContract = ILoanContract(loanContractAddress);

        vm.startBroadcast();

        loanContract.createLoan(borrowerAddress, loanAmount);

        vm.stopBroadcast();
    }
}