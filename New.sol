// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
合约部署合约的方法。之前的Proxy.sol中使用内联汇编的方式。
部署合约的核心是生成一个新的合约地址。但是新的合约地址针对不同的合约部署方式，
有不同的生成模式。
通过工厂合约的地址和工厂合约对外出的交易的noce值计算出来的新合约地址
*/

contract Account {
    address public bank;
    address public owner;

    constructor(address _owner) payable {
        bank = msg.sender;
        owner = _owner;
    }
}

contract AccountFactory {
    Account[] public accounts;

    function createAccount(address _owner) external payable {
        Account account = new Account{value: 123}(_owner); // 符合Account合约的构造函数。可以顺便传入主币。
        accounts.push(account);
    }
}
