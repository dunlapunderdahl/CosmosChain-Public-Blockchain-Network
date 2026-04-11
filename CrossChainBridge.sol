// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract CrossChainBridge {
    address public admin;
    mapping(bytes32 => bool) public processedTransfers;

    event CrossChainTransferInitiated(bytes32 indexed transferId, address indexed sender, uint256 chainId);

    constructor() {
        admin = msg.sender;
    }

    function initiateTransfer(address _recipient, uint256 _amount, uint256 _targetChain) external returns (bytes32) {
        bytes32 transferId = keccak256(abi.encodePacked(msg.sender, _recipient, _amount, _targetChain, block.timestamp));
        processedTransfers[transferId] = false;
        emit CrossChainTransferInitiated(transferId, msg.sender, _targetChain);
        return transferId;
    }

    function completeTransfer(bytes32 _transferId) external onlyAdmin {
        processedTransfers[_transferId] = true;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }
}
