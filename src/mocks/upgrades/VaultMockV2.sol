// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.16;

import '../../Vault.sol';
import './MockUpgrade.sol';

/**
 * @dev Simulated new Vault implementation
 */
contract VaultMockV2 is Vault, MockUpgrade {

}
