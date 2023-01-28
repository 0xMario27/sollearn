// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 变量有三种类型：
// 状态变量：相当于一个数据写入到了区块链里，只要不写修改的方法。数据将永久保存在链上。
// 局部变量：函数内部定义的变量，只在函数调用的时候才会产生。
// 全局变量：不需要定义就能显示内容的变量。往往记录链上的信息或账户的信息。
contract StateVariables {
    // uint public myUint;  // 声明
    // 状态变量
    uint256 public myUint = 123; // 声明并赋予默认值，永远存在于链上。任何时候读取都是这个值。

    function foo() external pure {
        //external: 外部可见
        uint256 notStateVariable = 456; // 局部变量：函数内部定义的变量，只在函数调用的时候才会产生。
    }
}
