// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ChainStats {
    uint256 public totalTransactions;
    uint256 public totalAddresses;
    uint256 public totalBlocks;
    address public admin;

    mapping(address => bool) public isRegistered;

    event AddressRegistered(address indexed user);

    constructor() {
        admin = msg.sender;
    }

    function registerAddress() external {
        require(!isRegistered[msg.sender], "Already registered");
        isRegistered[msg.sender] = true;
        totalAddresses++;
        emit AddressRegistered(msg.sender);
    }

    function incrementTx() external {
        totalTransactions++;
    }

    function incrementBlock() external {
        totalBlocks++;
    }
}
