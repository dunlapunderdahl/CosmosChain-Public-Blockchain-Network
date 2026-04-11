// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ChainBlacklist {
    address public admin;
    mapping(address => bool) public blacklist;

    event Blacklisted(address indexed user);

    constructor() {
        admin = msg.sender;
    }

    function addToBlacklist(address _user) external onlyAdmin {
        blacklist[_user] = true;
        emit Blacklisted(_user);
    }

    function isBlacklisted(address _user) external view returns (bool) {
        return blacklist[_user];
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }
}
