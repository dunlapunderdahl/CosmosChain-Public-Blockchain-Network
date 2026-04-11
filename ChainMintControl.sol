// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "./ChainToken.sol";

contract ChainMintControl {
    ChainToken public immutable token;
    address public admin;
    uint256 public dailyMintLimit;
    mapping(address => uint256) public mintedToday;

    constructor(address _token, uint256 _limit) {
        token = ChainToken(_token);
        admin = msg.sender;
        dailyMintLimit = _limit;
    }

    function mintTokens(address _to, uint256 _amount) external onlyAdmin {
        require(mintedToday[msg.sender] + _amount <= dailyMintLimit, "Daily limit reached");
        mintedToday[msg.sender] += _amount;
        token.transfer(_to, _amount);
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }
}
