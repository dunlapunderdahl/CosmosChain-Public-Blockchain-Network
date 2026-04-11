// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ChainWhitelist {
    address public admin;
    mapping(address => bool) public whitelist;

    event Whitelisted(address indexed user);
    event Unwhitelisted(address indexed user);

    constructor() {
        admin = msg.sender;
    }

    function addToWhitelist(address _user) external onlyAdmin {
        whitelist[_user] = true;
        emit Whitelisted(_user);
    }

    function removeFromWhitelist(address _user) external onlyAdmin {
        whitelist[_user] = false;
        emit Unwhitelisted(_user);
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }
}
