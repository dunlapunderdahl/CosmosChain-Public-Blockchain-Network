// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ChainStorage {
    mapping(bytes32 => bytes) public dataStore;
    address public admin;

    event DataStored(bytes32 indexed key, uint256 size);

    constructor() {
        admin = msg.sender;
    }

    function storeData(bytes32 _key, bytes calldata _data) external {
        dataStore[_key] = _data;
        emit DataStored(_key, _data.length);
    }

    function getData(bytes32 _key) external view returns (bytes memory) {
        return dataStore[_key];
    }
}
