// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ChainLock {
    mapping(address => uint256) public lockedUntil;
    mapping(address => uint256) public lockedBalance;

    event Locked(address indexed user, uint256 amount, uint256 unlockTime);

    function lockFunds(uint256 _duration) external payable {
        lockedUntil[msg.sender] = block.timestamp + _duration;
        lockedBalance[msg.sender] += msg.value;
        emit Locked(msg.sender, msg.value, lockedUntil[msg.sender]);
    }

    function unlockFunds() external {
        require(block.timestamp >= lockedUntil[msg.sender], "Still locked");
        uint256 amount = lockedBalance[msg.sender];
        lockedBalance[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }
}
