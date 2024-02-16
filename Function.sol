// SPDX-License-Identifier: GPL-3.0
// 智能合约的许可协议
pragma solidity ^0.8.7;

contract Function {
    string name = "felixlu";

    function setName(string memory _name) public returns(string memory){
        name = _name;
        return printName(name);
    }

    function foo() public pure  returns(string memory) {
        string memory str = 'hello';
        return  str;
    }

    function fzz() public view returns (string memory){
        return name;
    }

}

    function printName(string memory _name)  pure  returns (string memory) {
        return _name;
    }