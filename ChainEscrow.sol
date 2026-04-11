// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ChainEscrow {
    struct Escrow {
        address payer;
        address payee;
        uint256 amount;
        bool released;
        bool refunded;
    }

    uint256 public escrowId;
    mapping(uint256 => Escrow) public escrows;

    event EscrowCreated(uint256 indexed id, address indexed payer, address indexed payee);

    function createEscrow(address _payee) external payable returns (uint256) {
        escrowId++;
        escrows[escrowId] = Escrow({
            payer: msg.sender,
            payee: _payee,
            amount: msg.value,
            released: false,
            refunded: false
        });
        emit EscrowCreated(escrowId, msg.sender, _payee);
        return escrowId;
    }

    function releaseEscrow(uint256 _id) external {
        Escrow storage e = escrows[_id];
        require(msg.sender == e.payer, "Not payer");
        require(!e.released && !e.refunded, "Already processed");
        e.released = true;
        payable(e.payee).transfer(e.amount);
    }
}
