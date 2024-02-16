// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

import "./Context.sol";

contract MyToken is Context {
    // event Log(string);
    // event Log(uint);
    // — 1、代币信息 —

    //代币名称 name
    string private _name;
    //代币标识 symbol
    string private _sysmbole;
    //代币小数位数 decimals
    uint8 private _decimals;
    //代币的总发行量 totalSupply
    uint256 private _totalSupply;
    //代币数量 balance
    mapping(address => uint256) private _balance;
    //授权代币数量 allowance
    mapping(address => mapping(address => uint256)) private _allowance;

    // — 2、初始化 —
    constructor() {
        _name = "DragonCoin";
        _sysmbole = "DRABTC";
        _decimals = 18;

        // 初始化货币池
        _mint(_msgSender(), 100 * 10000 * 10**_decimals);
    }

    // — 3、取值器 —

    //返回代币的名字 name()
    function name() public view returns (string memory) {
        return _name;
    }

    // 返回代币标识
    function symbol() public view returns (string memory) {
        return _sysmbole;
    }

    // 返回  代币小数位数 decimals

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    // 返回代币的总发行量
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    //返回代币数量 balance
    function balanceOf(address _owner) public view returns (uint256 balance) {
        return _balance[_owner];
    }

    // 返回授权代币数量 allowanceOf()
     function allowanceOf(address _owner, address _spender) public view returns(uint256) {
        return _allowance[_owner][_spender];
    }

    // — 4、函数 —
    //代币转发
    function transfer(address _to, uint256 _amount) public returns (bool success) {
        address _owner = _msgSender();
        //实现转账
        _transfer(_owner, _to, _amount);
        return true;
    }

    // 授权代币的转发
    function approve(address _spender, uint256 _amount) public returns (bool success) {
        // 银行收取给我（银行要贷款给我）
        address _owner = _msgSender();
        //owner 是授权人
        //spender 被授权人
        _approve(_owner, _spender, _amount);
        return true;
    }

    // 授权代币转发
    function transferFrom(address _from, address _to, uint256 _amount) public returns (bool success){
        address _owner = _msgSender();
        // emit Log(unicode"授权代币转发---金额");
        // emit Log(_amount);
        _spendAllowance(_from, _owner, _amount);

        // 执行转账
        // from: 银行
        // to: 我自己，中介公司，买房人
        _transfer(_from, _to, _amount);
        return true;
    }
 

    // — 5、事件  —
    event Transfer(address _from, address _to, uint256 _amount);
    event Approval(address _owner, address _spender, uint256 _amount);

    // — 6、合约内部函数 —
    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: mint to the zero address");
        // 初始化货币数量
        _totalSupply += amount;

        //给某个账号注入起始资金
        unchecked {
            _balance[account] += amount;
        }
    }

    function _transfer(address _from, address _to, uint256 _amount) internal {
        require(_from != address(0), "ERC20: transfer from the zero address");
        require(_to != address(0), "ERC20: transfer to the zero address");

        uint256 fromBalance = _balance[_from];
        require(fromBalance >= _amount, "ERC20: balance");
        unchecked {
            _balance[_from] -= _amount;
            _balance[_to] += _amount;
        }
        emit Transfer(_from, _to, _amount);
    }

    function _approve(address _owner, address _spender, uint _amount) internal{
        require(_owner != address(0), "ERC20: transfer _owner the zero address");
        require(_spender != address(0), "ERC20: transfer _spender the zero address");
        //执行授权
        _allowance[_owner][_spender] = _amount;
        emit Approval(_owner, _spender, _amount);
    }

    function _spendAllowance(address _owner, address _spender, uint256 _amount) internal {
        uint256 currentAllowance = allowanceOf(_owner, _spender);
        if(currentAllowance != type(uint256).max){
            require(currentAllowance >= _amount, "ERC20: balance ");
            unchecked{
                _approve(_owner, _spender, currentAllowance- _amount);
            }

        }

    }
}

// function name() public view returns (string)
// function symbol() public view returns (string)
// function decimals() public view returns (uint8)
// function totalSupply() public view returns (uint256)
// function balanceOf(address _owner) public view returns (uint256 balance)
// function transfer(address _to, uint256 _value) public returns (bool success)
// function transferFrom(address _from, address _to, uint256 _value) public returns (bool success)
// function approve(address _spender, uint256 _value) public returns (bool success)
// function allowance(address _owner, address _spender) public view returns (uint256 remaining)

// event Transfer(address indexed _from, address indexed _to, uint256 _value)
// event Approval(address indexed _owner, address indexed _spender, uint256 _value)


/**
    主体：借款人，贷款人，中介公司，房屋出售者 account
    授权：贷款人（银行）借钱给我 approve  100w
    提款：从银行贷款账户里提钱给自己 transferFrom 1w
    支付房款：借款人转账给房屋出售者 transferFrom 90w
    支付佣金：借款人转账中介公司 transferFrom 9w
*/

/**
    0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
    0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
    0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB


    {
        0x5B38Da6a701c568545dCfcB03FcB875f56beddC4:{
            0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2:100w
        },
        0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db:{
            0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB:200w
        }
    }




*/