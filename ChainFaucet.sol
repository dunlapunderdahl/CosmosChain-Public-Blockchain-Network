// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ChainFaucet {
    address public admin;
    uint256 public dripAmount;
    mapping(address => uint256) public lastDrip;

    constructor() {
        admin = msg.sender;
        dripAmount = 0.1 ether;
    }

    function drip() external {
        require(block.timestamp > lastDrip[msg.sender] + 1 hours, "Cooldown active");
        lastDrip[msg.sender] = block.timestamp;
        payable(msg.sender).transfer(dripAmount);
    }

    receive() external payable {}
}
