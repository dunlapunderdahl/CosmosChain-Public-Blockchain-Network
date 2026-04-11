// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "./ChainToken.sol";

contract ChainAirdrop {
    ChainToken public immutable token;
    address public admin;
    mapping(address => bool) public claimed;

    event AirdropClaimed(address indexed user, uint256 amount);

    constructor(address _token) {
        token = ChainToken(_token);
        admin = msg.sender;
    }

    function claimAirdrop(uint256 _amount) external {
        require(!claimed[msg.sender], "Already claimed");
        claimed[msg.sender] = true;
        token.transfer(msg.sender, _amount);
        emit AirdropClaimed(msg.sender, _amount);
    }

    function resetClaim(address _user) external onlyAdmin {
        claimed[_user] = false;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }
}
