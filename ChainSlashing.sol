// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "./ValidatorManager.sol";

contract ChainSlashing {
    ValidatorManager public immutable validatorManager;
    uint256 public slashPercent;

    event ValidatorSlashed(address indexed validator, uint256 penalty);

    constructor(address _valManager) {
        validatorManager = ValidatorManager(_valManager);
        slashPercent = 5;
    }

    function slashValidator(address _validator) external {
        uint256 stake = validatorManager.validators(_validator).stakedAmount;
        uint256 penalty = stake * slashPercent / 100;
        emit ValidatorSlashed(_validator, penalty);
    }

    function updateSlashRate(uint256 _newPercent) external {
        slashPercent = _newPercent;
    }
}
