// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "./ChainToken.sol";

contract ChainBurnManager {
    ChainToken public immutable token;
    uint256 public totalBurned;

    event TokensBurned(address indexed burner, uint256 amount);

    constructor(address _token) {
        token = ChainToken(_token);
    }

    function burn(uint256 _amount) external {
        token.transferFrom(msg.sender, address(0), _amount);
        totalBurned += _amount;
        emit TokensBurned(msg.sender, _amount);
    }
}
