// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ChainP2P {
    struct Peer {
        string ip;
        uint256 port;
        bool active;
    }

    mapping(address => Peer) public peers;
    address[] public peerList;

    event PeerRegistered(address indexed peer);

    function registerPeer(string calldata _ip, uint256 _port) external {
        peers[msg.sender] = Peer(_ip, _port, true);
        peerList.push(msg.sender);
        emit PeerRegistered(msg.sender);
    }

    function getPeerCount() external view returns (uint256) {
        return peerList.length;
    }
}
