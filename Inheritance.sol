// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 继承
// 单线继承

contract A {
    // virtual 定义为可以被重写的。
    function foo() public pure virtual returns (string memory) {
        return "A";
    }

    function bar() public pure virtual returns (string memory) {
        return "A";
    }

    // 没有加virtual的函数是可以被B继承到的
    function baz() public pure returns (string memory) {
        return "A";
    }
}

// is 表示B继承与A
contract B is A {
    // override 代表重写对应的函数
    function foo() public pure override returns (string memory) {
        return "B";
    }

    // virtual override 代表继承的A的依然提供可以重写B中重写完A的函数
    function bar() public pure virtual override returns (string memory) {
        return "B";
    }
}

contract C is B {
    // override 重写
    function bar() public pure override returns (string memory) {
        return "B";
    }
}
