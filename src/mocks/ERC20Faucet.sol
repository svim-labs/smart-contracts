// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// this contract is just for testing purpose.
contract ERC20Faucet is Ownable, ERC20Burnable {
    constructor(
        string memory _name,
        string memory _symbol
    ) ERC20(_name, _symbol) {
        _mint(msg.sender, 10000000000e18);
    }

    /**
    @param account address to which company token will be minted
    @param amount tokens amount minted to account
    */
    function mint(address account, uint256 amount) external {
        super._mint(account, amount);
    }

    function decimals() public view virtual override returns (uint8) {
        return 18;
    }
}
