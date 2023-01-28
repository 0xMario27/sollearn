// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FunctionIntro {
    // 主要介绍两个简单的函数。加法和减法。
    // 关键词介绍：
    // external： 代表着外部函数，只能在外部读取的函数。
    // pure: 纯函数的概念。指这个函数不能读写状态变量，只能拥有局部变量。完全不对链上进行读写操作。
    // view: 只读取合约的状态变量。保证不对合约的数据状态进行修改。
    // payable: 
    // 关键字 函数名 参数           external  pure/view 返回值定义
    function add(uint256 x, uint256 y) external pure returns (uint256) {
        return x + y;
    }

    function sub(uint256 x, uint256 y) external pure returns (uint256) {
        return x - y;
    }
}
