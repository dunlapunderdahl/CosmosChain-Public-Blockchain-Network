// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

library ChainHelper {
    function compareStrings(string calldata a, string calldata b) internal pure returns (bool) {
        return keccak256(bytes(a)) == keccak256(bytes(b));
    }

    function toBytes(uint256 x) internal pure returns (bytes memory) {
        bytes memory b = new bytes(32);
        assembly { mstore(add(b, 32), x) }
        return b;
    }
}
