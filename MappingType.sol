// SPDX-License-Identifier: GPL-3.0
// 智能合约的许可协议
pragma solidity ^0.8.7;

contract MappingType {
    mapping (address=>uint) public balance;
    //mapping (address=>mapping(address=>uint)) xxx;
    /*

    0x5B38Da6a701c568545dCfcB03FcB875f56beddC4:1000,
    0x5B38Da6a701c568545dCfcB03FcB875f56sdfe36:2000

    */

    function setBalance(uint256 amount) public {
        balance[msg.sender] = amount;
    }
//address owner
    function balanceOf() view public  returns(uint256)  {
        return balance[msg.sender];
    }
    
}
