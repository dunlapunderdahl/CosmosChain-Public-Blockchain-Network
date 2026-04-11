// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ChainWeb3 {
    mapping(address => string) public userProfiles;
    address public admin;

    event ProfileUpdated(address indexed user, string data);

    constructor() {
        admin = msg.sender;
    }

    function setProfile(string calldata _data) external {
        userProfiles[msg.sender] = _data;
        emit ProfileUpdated(msg.sender, _data);
    }
}
