// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import '../../controllers/WithdrawController.sol';
import './MockUpgrade.sol';

/**
 * @dev Simulated new ServiceConfiguration implementation
 */
contract WithdrawControllerMockV2 is WithdrawController, MockUpgrade {

}
