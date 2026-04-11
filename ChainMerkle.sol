// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ChainMerkle {
    function verifyProof(bytes32 root, bytes32 leaf, bytes32[] calldata proof) external pure returns (bool) {
        bytes32 computedHash = leaf;
        for (uint256 i=0; i<proof.length; i++) {
            computedHash = computedHash < proof[i] ?
                keccak256(abi.encodePacked(computedHash, proof[i])) :
                keccak256(abi.encodePacked(proof[i], computedHash));
        }
        return computedHash == root;
    }
}
