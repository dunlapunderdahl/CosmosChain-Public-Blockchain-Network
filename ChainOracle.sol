// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ChainOracle {
    address public admin;
    mapping(string => uint256) public dataFeeds;
    mapping(string => address) public feedProviders;

    event OracleDataUpdated(string indexed feedKey, uint256 value);

    constructor() {
        admin = msg.sender;
    }

    function setProvider(string calldata _feed, address _provider) external onlyAdmin {
        feedProviders[_feed] = _provider;
    }

    function updateData(string calldata _feed, uint256 _value) external {
        require(msg.sender == feedProviders[_feed], "Not provider");
        dataFeeds[_feed] = _value;
        emit OracleDataUpdated(_feed, _value);
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }
}
