// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import '../Pool.sol';
import '../interfaces/IServiceConfiguration.sol';
import './interfaces/IPoolFactory.sol';
import { BeaconProxy } from '@openzeppelin/contracts/proxy/beacon/BeaconProxy.sol';
import '../upgrades/BeaconProxyFactory.sol';

/**
 * @title A factory that emits Pool contracts.
 * @dev Acts as a beacon contract, emitting beacon proxies and holding a reference
 * to their implementation contract.
 */
contract PoolFactory is IPoolFactory, BeaconProxyFactory {
  /**
   * @dev Reference to the WithdrawControllerFactory contract
   */
  address internal _withdrawControllerFactory;

  /**
   * @dev Reference to the PoolControllerFactory contract
   */
  address internal _poolControllerFactory;

  /**
   * @dev Reference to the VaultFactory contract
   */
  address internal _vaultFactory;

  /**
   * @dev Constructor
   * @param serviceConfiguration Reference to the global service configuration.
   * @param withdrawControllerFactory Reference to the withdraw controller factory.
   * @param poolControllerFactory Reference to the pool controller factory.
   * @param vaultFactory Reference to the Vault factory.
   */
  constructor(
    address serviceConfiguration,
    address withdrawControllerFactory,
    address poolControllerFactory,
    address vaultFactory
  ) {
    _serviceConfiguration = IServiceConfiguration(serviceConfiguration);
    _withdrawControllerFactory = withdrawControllerFactory;
    _poolControllerFactory = poolControllerFactory;
    _vaultFactory = vaultFactory;
  }

  /**
   * @inheritdoc IPoolFactory
   */
  function createPool(
    address liquidityAsset,
    IPoolConfigurableSettings calldata settings,
    string calldata name,
    string calldata symbol
  ) public virtual returns (address poolAddress) {
    require(implementation != address(0), 'PoolFactory: no implementation set');
    require(_serviceConfiguration.paused() == false, 'PoolFactory: Protocol paused');
    require(settings.withdrawRequestPeriodDuration > 0, 'PoolFactory: Invalid duration');
    if (settings.fixedFee > 0) {
      require(settings.fixedFeeInterval > 0, 'PoolFactory: Invalid fixed fee interval');
    }
    require(
      settings.firstLossInitialMinimum >= _serviceConfiguration.firstLossMinimum(liquidityAsset),
      'PoolFactory: Invalid first loss minimum'
    );
    require(settings.withdrawGateBps <= 10_000, 'PoolFactory: Invalid withdraw gate');
    require(settings.requestFeeBps <= 10_000, 'PoolFactory: Invalid request fee');
    require(settings.requestCancellationFeeBps <= 10_000, 'PoolFactory: Invalid request cancellation fee');
    require(settings.serviceFeeBps <= 10_000, 'PoolFactory: Invalid service fee');
    require(_serviceConfiguration.isLiquidityAsset(liquidityAsset), 'PoolFactory: invalid asset');

    // Create the pool
    address addr = initializePool(liquidityAsset, settings, name, symbol);
    emit PoolCreated(addr);
    return addr;
  }

  /**
   * @dev Creates the new Pool contract.
   */
  function initializePool(
    address liquidityAsset,
    IPoolConfigurableSettings calldata settings,
    string calldata name,
    string calldata symbol
  ) internal virtual returns (address) {
    // Create beacon proxy
    BeaconProxy proxy = new BeaconProxy(
      address(this),
      abi.encodeWithSelector(
        Pool.initialize.selector,
        liquidityAsset,
        msg.sender,
        _serviceConfiguration,
        _withdrawControllerFactory,
        _poolControllerFactory,
        _vaultFactory,
        settings,
        name,
        symbol
      )
    );
    return address(proxy);
  }
}
