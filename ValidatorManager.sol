// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "./ChainToken.sol";

contract ValidatorManager {
    ChainToken public immutable token;
    address public chainAdmin;
    uint256 public minStake;

    struct Validator {
        address validatorAddr;
        uint256 stakedAmount;
        bool isActive;
        uint256 joinHeight;
    }

    mapping(address => Validator) public validators;
    address[] public validatorList;

    event ValidatorStaked(address indexed validator, uint256 amount);
    event ValidatorUnstaked(address indexed validator, uint256 amount);

    constructor(address _tokenAddr, uint256 _minStake) {
        token = ChainToken(_tokenAddr);
        chainAdmin = msg.sender;
        minStake = _minStake;
    }

    function stakeAsValidator(uint256 _amount) external {
        require(_amount >= minStake, "Below minimum stake");
        require(token.transferFrom(msg.sender, address(this), _amount), "Transfer failed");
        
        Validator storage val = validators[msg.sender];
        val.validatorAddr = msg.sender;
        val.stakedAmount += _amount;
        val.isActive = true;
        val.joinHeight = block.number;

        validatorList.push(msg.sender);
        emit ValidatorStaked(msg.sender, _amount);
    }

    function unstakeValidator(uint256 _amount) external {
        Validator storage val = validators[msg.sender];
        require(val.stakedAmount >= _amount, "Insufficient stake");
        val.stakedAmount -= _amount;
        if (val.stakedAmount == 0) val.isActive = false;
        require(token.transfer(msg.sender, _amount), "Transfer failed");
        emit ValidatorUnstaked(msg.sender, _amount);
    }

    function getValidatorCount() external view returns (uint256) {
        return validatorList.length;
    }
}
