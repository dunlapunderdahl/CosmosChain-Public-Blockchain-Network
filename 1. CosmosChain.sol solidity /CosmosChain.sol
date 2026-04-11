// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract CosmosChain {
    address public immutable chainAdmin;
    uint256 public chainHeight;
    mapping(uint256 => bytes32) public blockHashes;

    event NewBlockMinted(uint256 indexed height, bytes32 blockHash);

    constructor() {
        chainAdmin = msg.sender;
        chainHeight = 0;
    }

    function mintNewBlock(bytes32 _blockHash) external onlyAdmin {
        chainHeight++;
        blockHashes[chainHeight] = _blockHash;
        emit NewBlockMinted(chainHeight, _blockHash);
    }

    modifier onlyAdmin() {
        require(msg.sender == chainAdmin, "Not chain admin");
        _;
    }

    function getLatestBlockHash() external view returns (bytes32) {
        return blockHashes[chainHeight];
    }
}
