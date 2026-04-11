// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ChainUpgrade {
    address public admin;
    address public newContract;
    uint256 public upgradeTime;

    event UpgradeScheduled(address indexed newImpl, uint256 time);

    constructor() {
        admin = msg.sender;
    }

    function scheduleUpgrade(address _newImpl, uint256 _time) external onlyAdmin {
        newContract = _newImpl;
        upgradeTime = _time;
        emit UpgradeScheduled(_newImpl, _time);
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }
}
