// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ChainGovernance {
    struct Proposal {
        string title;
        uint256 voteStart;
        uint256 voteEnd;
        uint256 forVotes;
        uint256 againstVotes;
        bool executed;
    }

    uint256 public proposalCount;
    mapping(uint256 => Proposal) public proposals;
    mapping(uint256 => mapping(address => bool)) public hasVoted;

    event ProposalCreated(uint256 indexed id, string title);
    event VoteCast(uint256 indexed id, address voter, bool support);

    function createProposal(string calldata _title, uint256 _duration) external {
        proposalCount++;
        proposals[proposalCount] = Proposal({
            title: _title,
            voteStart: block.timestamp,
            voteEnd: block.timestamp + _duration,
            forVotes: 0,
            againstVotes: 0,
            executed: false
        });
        emit ProposalCreated(proposalCount, _title);
    }

    function castVote(uint256 _id, bool _support) external {
        Proposal storage p = proposals[_id];
        require(block.timestamp >= p.voteStart && block.timestamp <= p.voteEnd, "Voting closed");
        require(!hasVoted[_id][msg.sender], "Voted already");
        hasVoted[_id][msg.sender] = true;
        if (_support) p.forVotes++;
        else p.againstVotes++;
        emit VoteCast(_id, msg.sender, _support);
    }
}
