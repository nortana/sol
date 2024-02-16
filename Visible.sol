// SPDX-License-Identifier: GPL-3.0
// 智能合约的许可协议
pragma solidity ^0.8.7;

contract Visible {
    uint256 private x;

    constructor(uint _x) {
        x = _x;
    }

    function getX() external view returns (uint256) {
        return x;
    }
}
