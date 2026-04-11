// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ChainAccess {
    address public admin;
    mapping(bytes4 => bool) public allowedMethods;

    constructor() {
        admin = msg.sender;
    }

    function allowMethod(bytes4 _sig) external onlyAdmin {
        allowedMethods[_sig] = true;
    }

    function isMethodAllowed(bytes4 _sig) external view returns (bool) {
        return allowedMethods[_sig];
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }
}
