// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ChainIdentity {
    struct Identity {
        string username;
        string metadata;
        bool isVerified;
        uint256 registerTime;
    }

    mapping(address => Identity) public identities;

    event IdentityRegistered(address indexed user, string username);

    function registerIdentity(string calldata _username, string calldata _meta) external {
        require(bytes(identities[msg.sender].username).length == 0, "Already registered");
        identities[msg.sender] = Identity({
            username: _username,
            metadata: _meta,
            isVerified: false,
            registerTime: block.timestamp
        });
        emit IdentityRegistered(msg.sender, _username);
    }

    function verifyIdentity(address _user) external {
        identities[_user].isVerified = true;
    }
}
