// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

library ChainConstants {
    uint256 public constant MAX_SUPPLY = 1e9 * 1e18;
    uint256 public constant BLOCK_TIME = 3 seconds;
    uint256 public constant MAX_GAS = 30000000;
    string public constant CHAIN_NAME = "CosmosChain";
}
