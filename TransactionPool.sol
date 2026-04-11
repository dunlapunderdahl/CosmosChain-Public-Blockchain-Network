// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract TransactionPool {
    struct Tx {
        address sender;
        address receiver;
        uint256 value;
        uint256 gasFee;
        bool processed;
    }

    uint256 public txCount;
    mapping(uint256 => Tx) public transactions;

    event TransactionAdded(uint256 indexed txId, address indexed sender);

    function addTransaction(address _receiver, uint256 _value, uint256 _gasFee) external {
        txCount++;
        transactions[txCount] = Tx({
            sender: msg.sender,
            receiver: _receiver,
            value: _value,
            gasFee: _gasFee,
            processed: false
        });
        emit TransactionAdded(txCount, msg.sender);
    }

    function markProcessed(uint256 _txId) external {
        require(_txId <= txCount, "Invalid tx");
        transactions[_txId].processed = true;
    }

    function getPendingTxCount() external view returns (uint256) {
        uint256 count;
        for (uint256 i=1; i<=txCount; i++) {
            if (!transactions[i].processed) count++;
        }
        return count;
    }
}
