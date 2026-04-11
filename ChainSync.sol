// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ChainSync {
    uint256 public latestSyncedHeight;
    address public admin;

    event ChainSynced(uint256 indexed height);

    constructor() {
        admin = msg.sender;
    }

    function updateSyncHeight(uint256 _height) external onlyAdmin {
        require(_height > latestSyncedHeight, "Invalid height");
        latestSyncedHeight = _height;
        emit ChainSynced(_height);
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }
}
