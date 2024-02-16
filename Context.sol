// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Context {
    function _msgSender() public view  returns (address) {
        return msg.sender;
    }
}
