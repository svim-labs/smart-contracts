// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import './interfaces/IVault.sol';
import './interfaces/IServiceConfiguration.sol';
import './upgrades/BeaconImplementation.sol';
import { IERC20Upgradeable } from '@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol';
import { SafeERC20Upgradeable } from '@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol';
import { OwnableUpgradeable } from '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';
import { SafeERC20Upgradeable } from '@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol';

/**
 * @title Vault holds a balance, and allows withdrawals to the Vault's owner.
 * @dev Vaults are deployed as beacon proxy contracts.
 */
contract Vault is IVault, OwnableUpgradeable, BeaconImplementation {
  using SafeERC20Upgradeable for IERC20Upgradeable;

  /**
   * @dev Reference to the global service configuration
   */
  IServiceConfiguration private _serviceConfiguration;

  /**
   * @dev Modifier to check that the protocol is not paused
   */
  modifier onlyNotPaused() {
    require(!_serviceConfiguration.paused(), 'Vault: Protocol paused');
    _;
  }

  /**
   * @dev Initialize function as a Beacon proxy implementation.
   */
  function initialize(address owner, address serviceConfiguration) public initializer {
    _transferOwnership(owner);
    _serviceConfiguration = IServiceConfiguration(serviceConfiguration);
  }

  /**
   * @inheritdoc IVault
   */
  function withdrawERC20(address asset, uint256 amount, address receiver) external override onlyOwner onlyNotPaused {
    require(receiver != address(0), 'Vault: 0 address');
    IERC20Upgradeable(asset).safeTransfer(receiver, amount);
    emit WithdrewERC20(asset, amount, receiver);
  }

}
