// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

/*
不可变量：
对比于常量，我们在定义常量的时候是事先知道常量的值的，
但是很多时候我们在事先并不知道常量的值。
*/

contract Immutable {
    // 在部署合约的时候一次定义成功。后面就不可改变。当成常量对待。
    // 好处可以跟常量一样节约gas，也可以在部署的时候动态给值。

    // 两种写法都可以
    address public immutable owner; // = msg.sender;

    // 还可以写在构造函数里
    constructor() {
        /*
        如果我们不在定义的时候给immutable变量赋值，
        也不在构造函数中给它赋值，
        那么在编译的时候就会报错。
        */
        owner = msg.sender;
    }

    uint256 public x;

    function foo() external {
        require(msg.sender == owner);
        x += 1;
    }
}
