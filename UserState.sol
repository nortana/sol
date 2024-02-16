// SPDX-License-Identifier: GPL-3.0
// 智能合约的许可协议
pragma solidity ^0.8.7;

contract UserState{

    //枚举
    //默认值是列表中的第一个元素
    enum State{
        Online,   //0
        Offline,  //1
        Unknown  //2
    }

    State public status;
    function get() public view returns(State){
        return status;
    } 

    //通过将uint 传递到输入来更新状态
    function set(State _status) public {
        status = _status;
    }

    //也可以是这样确定属性的更新
    function off() public {
        status = State.Offline;
    }

    //delete 将枚举重置为第一个值0
    function reset() public {
        delete status;
    }

}