// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ChainTimelock {
    address public admin;
    uint256 public delay;
    mapping(bytes32 => uint256) public queueTime;

    constructor(uint256 _delay) {
        admin = msg.sender;
        delay = _delay;
    }

    function queueTransaction(bytes32 _id) external onlyAdmin {
        queueTime[_id] = block.timestamp;
    }

    function executeTransaction(bytes32 _id) external onlyAdmin {
        require(block.timestamp >= queueTime[_id] + delay, "Not ready");
        queueTime[_id] = 0;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }
}
