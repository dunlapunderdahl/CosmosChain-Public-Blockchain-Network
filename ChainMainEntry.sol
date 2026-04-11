// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "./CosmosChain.sol";
import "./ChainToken.sol";
import "./ValidatorManager.sol";

contract ChainMainEntry {
    CosmosChain public chain;
    ChainToken public token;
    ValidatorManager public validatorManager;

    constructor() {
        token = new ChainToken(1e9);
        chain = new CosmosChain();
        validatorManager = new ValidatorManager(address(token), 1e18);
    }

    function getSystemInfo() external view returns (address, address, address) {
        return (address(chain), address(token), address(validatorManager));
    }
}
