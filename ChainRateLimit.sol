// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ChainRateLimit {
    mapping(address => uint256) public lastAction;
    uint256 public cooldown;

    constructor(uint256 _cooldown) {
        cooldown = _cooldown;
    }

    function checkRateLimit() external returns (bool) {
        if (block.timestamp < lastAction[msg.sender] + cooldown) return false;
        lastAction[msg.sender] = block.timestamp;
        return true;
    }
}
