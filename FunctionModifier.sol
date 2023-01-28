// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FunctionModifier {
    bool public paused;
    uint256 public count;

    function setPause(bool _paused) external {
        paused = _paused;
    }

    // 定义函数修改器(类似于python的装饰器)
    modifier whenNotPaused() {
        require(!paused, "paused");
        _; // 代表 着函数的其他代码的执行位置，相当于代码的占位符
    }

    // function inc() external {
    //     require(!paused, "paused"); // 冗余部分，可以用函数修改器解决
    //     count += 1;
    // }

    function inc() external whenNotPaused {
        // 执行顺序是先执行函数修改器的代码。当遇到"_"代码时，跳回函数执行函数内容。
        count += 1;
    }

    // function dec() external {
    //     require(!paused, "paused"); // 冗余部分，可以用函数修改器解决
    //     count -= 1;
    // }
    function dec() external whenNotPaused {
        count -= 1;
    }

    // 定义带参数的函数修改器
    modifier cap(uint256 _x) {
        require(_x < 100, "x >= 100");
        _;
    }

    // 需要带参数的修改器
    function incBy(uint256 _x) external cap(_x) {
        count += _x;
    }

    // 三明治写法
    modifier sandwich() {
        count += 10;
        _;
        count *= 2;
    }

    function foo() external sandwich {
        count += 1;
    }
}
// 疑问
// 1、如果函数定义有多种关键字，比如view,pure,returns等应该把函数修改器放在什么位置。
// 2、如果函数修改器中"_"之后还有代码。执行完函数后还会跳转回函数修改器吗？
//    - 三明治写法。
// 3、是否可以定义多个函数修改器。如果可以那么执行顺序是什么。
