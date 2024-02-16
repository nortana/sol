// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract MyTo2 is ERC20, ERC20Permit {
    constructor() ERC20("MyTo2", "MTK2") ERC20Permit("MyTo2") {
        _mint(msg.sender, 10000000 * 10 ** decimals());
    }
}