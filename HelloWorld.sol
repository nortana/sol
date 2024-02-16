// SPDX-License-Identifier: GPL-3.0
// 智能合约的许可协议
pragma solidity ^0.8.7;

// 智能合约的适⽤版本
contract HelloWord {
    //状态变量
    string public name;

    constructor() {
        name = "web3";
    }

    function sayName() public view returns (string memory) {
        return name;
    }

    function changeName(string memory _name) public {
     
      
         
        name = _name;
         //address a = msg.sender;
    }
}
