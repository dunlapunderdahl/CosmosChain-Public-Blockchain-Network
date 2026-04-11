// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ChainSnapshot {
    struct Snapshot {
        uint256 blockHeight;
        bytes32 stateHash;
        uint256 timestamp;
    }

    uint256 public snapshotCount;
    mapping(uint256 => Snapshot) public snapshots;

    event SnapshotCreated(uint256 indexed id, uint256 height);

    function createSnapshot(uint256 _height, bytes32 _hash) external {
        snapshotCount++;
        snapshots[snapshotCount] = Snapshot(_height, _hash, block.timestamp);
        emit SnapshotCreated(snapshotCount, _height);
    }
}
