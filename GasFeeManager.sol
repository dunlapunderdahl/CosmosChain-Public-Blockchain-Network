// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract GasFeeManager {
    address public admin;
    uint256 public baseGasFee;
    uint256 public burnRate;

    address public feeCollector;
    mapping(address => uint256) public collectedFees;

    event GasFeeCollected(address indexed user, uint256 amount);

    constructor() {
        admin = msg.sender;
        baseGasFee = 1e14;
        burnRate = 10;
        feeCollector = msg.sender;
    }

    function collectFee(address _user) external payable {
        uint256 fee = baseGasFee;
        collectedFees[_user] += fee;
        emit GasFeeCollected(_user, fee);
    }

    function updateBaseFee(uint256 _newFee) external onlyAdmin {
        baseGasFee = _newFee;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }
}
