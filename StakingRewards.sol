// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "./ChainToken.sol";
import "./ValidatorManager.sol";

contract StakingRewards {
    ChainToken public immutable token;
    ValidatorManager public immutable validatorManager;
    uint256 public rewardRate;

    mapping(address => uint256) public lastClaim;

    constructor(address _token, address _validatorManager, uint256 _rate) {
        token = ChainToken(_token);
        validatorManager = ValidatorManager(_validatorManager);
        rewardRate = _rate;
    }

    function claimRewards() external {
        uint256 stake = validatorManager.validators(msg.sender).stakedAmount;
        require(stake > 0, "No stake");
        uint256 duration = block.timestamp - lastClaim[msg.sender];
        uint256 reward = stake * rewardRate * duration / 365 days;
        lastClaim[msg.sender] = block.timestamp;
        token.transfer(msg.sender, reward);
    }

    function updateRewardRate(uint256 _newRate) external {
        rewardRate = _newRate;
    }
}
