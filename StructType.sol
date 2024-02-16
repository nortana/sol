// SPDX-License-Identifier: GPL-3.0
// 智能合约的许可协议
pragma solidity ^0.8.7;

contract StructType {
    struct Person{
        string name;
        string gender;
        uint age;
    }

    Person person;

    function initial(string calldata name, string calldata gender,uint age) public{
        person.name = name;
        person.age = age;
        person.gender = gender;

    }


    
}