// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import '../../controllers/PoolController.sol';
import './MockUpgrade.sol';

/**
 * @dev Simulated new ServiceConfiguration implementation
 */
contract PoolControllerMockV2 is PoolController, MockUpgrade {

}
