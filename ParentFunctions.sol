// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

// 如何调用父级合约的函数
/*
    E
  |   \
 F     G
  \   |
    H
*/
contract E {
    event Log(string message);

    function foo() public virtual {
        emit Log("E.foo");
    }

    function bar() public virtual {
        emit Log("E.bar");
    }
}

// 两种调用方法
// 1、直接指定父级合约
// 2、使用super关键字
contract F is E {
    function foo() public virtual override {
        emit Log("F.foo");
        E.foo();
    }

    function bar() public virtual override {
        emit Log("F.bar");
        super.bar();
    }
}

contract G is E {
    function foo() public virtual override {
        emit Log("G.foo");
        E.foo();
    }

    function bar() public virtual override {
        emit Log("G.bar");
        super.bar();
    }
}

// 多重继承的时候super关键字会分别执行多个继承
// 实际测试多个合约的时候调用的函数顺序是继承顺序的逆序？有待深入。
// 但最后虽然都会执行E合约的bar函数。但是其实只执行一次E的bar
contract H is F, G {
    function foo() public virtual override(F, G) {
        F.foo();
    }

    function bar() public virtual override(F, G) {
        super.bar();
    }
}
// 疑问
// 1、实际测试多个合约的时候调用的函数顺序是继承顺序的逆序？有待深入。
