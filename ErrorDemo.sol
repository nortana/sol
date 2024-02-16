// SPDX-License-Identifier: GPL-3.0
// 智能合约的许可协议
pragma solidity ^0.8.7;

contract ErrorDemo {
    uint256 x = 100;

    function doAssert() public returns (uint256) {
        //  assert(3>5);
        require(3 > 5);//不会消耗一下的gas
        x = 200;
        return x;
    }
}
