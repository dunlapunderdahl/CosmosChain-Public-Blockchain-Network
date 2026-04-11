// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ChainMultisig {
    address[] public owners;
    uint256 public required;

    struct Transaction {
        address to;
        uint256 value;
        bool executed;
        uint256 confirmations;
    }

    mapping(uint256 => Transaction) public transactions;
    mapping(uint256 => mapping(address => bool)) public confirmations;
    uint256 public txCount;

    constructor(address[] memory _owners, uint256 _required) {
        owners = _owners;
        required = _required;
    }

    function submitTransaction(address _to, uint256 _value) external onlyOwner {
        txCount++;
        transactions[txCount] = Transaction(_to, _value, false, 0);
    }

    function confirmTransaction(uint256 _txId) external onlyOwner {
        require(!confirmations[_txId][msg.sender], "Already confirmed");
        confirmations[_txId][msg.sender] = true;
        transactions[_txId].confirmations++;
    }

    modifier onlyOwner() {
        bool isOwner;
        for (uint256 i=0; i<owners.length; i++) {
            if (owners[i] == msg.sender) { isOwner = true; break; }
        }
        require(isOwner, "Not owner");
        _;
    }
}
