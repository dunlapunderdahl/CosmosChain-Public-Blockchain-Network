// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ChainProxy {
    address public implementation;
    address public admin;

    event Upgraded(address indexed newImpl);

    constructor(address _impl) {
        implementation = _impl;
        admin = msg.sender;
    }

    function upgradeTo(address _newImpl) external onlyAdmin {
        implementation = _newImpl;
        emit Upgraded(_newImpl);
    }

    fallback() external payable {
        address _impl = implementation;
        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), _impl, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0 { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }
}
