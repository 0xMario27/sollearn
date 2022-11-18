// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

/*
合约部署合约的方法。之前的Proxy.sol中使用内联汇编的方式。
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
