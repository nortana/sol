// SPDX-License-Identifier: GPL-3.0
// 智能合约的许可协议
pragma solidity ^0.8.7;

contract StoreType {
    string name;
}

contract Person {
    struct State {
        string name;
        string gender;
    }

    State public state;

    function setState(string calldata _name, string calldata _gender) external {
        state.name = _name;
        state.gender = _gender;
    }

    function getName() external view returns (string memory) {
        return state.name;
    }

    function changeGender(uint256 value) external {
        require(value == 0 || value == 1, "Person: Input value error.");
        string memory newGender;

        // if (value == 0) {
        //     newGender = "female";
        // } else {
        //     newGender = "male";
        // }

        newGender = value == 0 ? "female" : "male";
        state.gender = newGender;
    }
}

contract Counter {
    function start() external pure  returns (uint sum) {
        uint a1 = 1;
        uint a2 = 1;
        uint a3 = 1;
        uint a4 = 1;
        uint a5 = 1;
      //  uint a6 = 6;
        //uint a7 = 7;
      //  uint a8 = 8;
       // uint a9 = 9;
         sum = a1 + a2 + a3 + a4+a5; //+ a5 + a6 + a7 + a8 + a9;
    }
}
