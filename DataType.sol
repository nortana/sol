// SPDX-License-Identifier: GPL-3.0
// 智能合约的许可协议
pragma solidity ^0.8.7;

contract DataType{
    int x = -100;
    uint y = 10;

    uint8 z = 10;

    //int 的最小值 最大值
    int public minInt = type(int).min;
    int public  maxInt = type(int).max;


    //uint 的最大最小值
    uint public minUint = type(uint).min;
    uint public maxUint = type(uint).max;

    //花费
    constructor  () payable {
         
    }
    address public  a = msg.sender;
    address public b = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    address public c = address(this);


}

contract StringType {

    string public str1 = "123";

    //中文不适用unicode 编码器
    string public str2 = unicode"abc";
    function concat() public view returns(string memory) {
        string memory result = string.concat(str1,str2);
        return result;
    }

    function concat2(string memory _a, string memory _b) public pure returns (string memory){
        bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);

        return string(bytes.concat(_ba,_bb));

    }

    function testString() public view returns (uint) {
        bytes memory a = bytes(str1);
        return a.length;
    }

    function concat3() public view returns (string memory){
        return string(abi.encodePacked(str1,str2));
    }
    
}