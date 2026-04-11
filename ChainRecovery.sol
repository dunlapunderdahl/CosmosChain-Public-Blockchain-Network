// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ChainRecovery {
    mapping(address => address) public recoveryAddress;
    mapping(address => uint256) public requestTime;

    event RecoveryRequested(address indexed user, address indexed recovery);

    function setRecovery(address _recovery) external {
        recoveryAddress[msg.sender] = _recovery;
    }

    function requestRecovery(address _target) external {
        require(msg.sender == recoveryAddress[_target], "Not recovery");
        requestTime[_target] = block.timestamp;
        emit RecoveryRequested(_target, msg.sender);
    }
}
