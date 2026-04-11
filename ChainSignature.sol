// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ChainSignature {
    function verifySignature(bytes32 _hash, bytes calldata _sig, address _signer) external pure returns (bool) {
        bytes32 r; bytes32 s; uint8 v;
        assembly {
            r := calldataload(_sig.offset)
            s := calldataload(add(_sig.offset, 32))
            v := byte(0, calldataload(add(_sig.offset, 64)))
        }
        if (v < 27) v += 27;
        return ecrecover(_hash, v, r, s) == _signer;
    }
}
