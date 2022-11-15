// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

// 构造函数
// 仅能在合约部署的时候被调用一次，之后就再也不能被调用了
// 一般用于初始化一些变量的操作
contract Constructor {
    address public owner;
    uint256 public x;

    constructor(uint256 _x) {
        owner = msg.sender;
        x = _x;
    }
}
