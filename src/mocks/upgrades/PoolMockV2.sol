// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import '../../Pool.sol';
import './MockUpgrade.sol';

/**
 * @dev Simulated new Pool implementation
 */
contract PoolMockV2 is Pool, MockUpgrade {

}
