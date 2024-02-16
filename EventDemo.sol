// SPDX-License-Identifier: GPL-3.0
// 智能合约的许可协议
pragma solidity ^0.8.7;

contract EventDemo {
    event Log(uint);
    event Log(string);
    event Log(address);



    function foo() public {
        emit Log(100);
        emit Log(unicode"hello world.");
        emit Log(msg.sender);
    }
}