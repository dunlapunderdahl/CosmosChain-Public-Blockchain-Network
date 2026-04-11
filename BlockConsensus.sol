// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract BlockConsensus {
    address public admin;
    mapping(uint256 => mapping(address => bool)) public votes;
    mapping(uint256 => uint256) public voteCount;

    event ConsensusVoteCast(uint256 indexed blockHeight, address indexed validator);

    constructor() {
        admin = msg.sender;
    }

    function castVote(uint256 _blockHeight) external {
        require(!votes[_blockHeight][msg.sender], "Already voted");
        votes[_blockHeight][msg.sender] = true;
        voteCount[_blockHeight]++;
        emit ConsensusVoteCast(_blockHeight, msg.sender);
    }

    function checkConsensus(uint256 _blockHeight, uint256 _requiredVotes) external view returns (bool) {
        return voteCount[_blockHeight] >= _requiredVotes;
    }
}
