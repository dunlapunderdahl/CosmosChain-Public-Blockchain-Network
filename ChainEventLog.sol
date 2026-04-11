// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ChainEventLog {
    struct Log {
        address caller;
        string action;
        uint256 time;
    }

    uint256 public logCount;
    mapping(uint256 => Log) public logs;

    function logAction(string calldata _action) external {
        logCount++;
        logs[logCount] = Log(msg.sender, _action, block.timestamp);
    }
}
