// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

// 可视范围

// private：私有，仅在合约的内部可见。
// internal：内部，在合约的内部和被继承的子合约都可以看到。
// public：在内部、被继承的和外部都可以看到。
// external：仅在合约外部可以看到。内部看不到。
// 可以用在状态变量中也可以用在函数中。

contract VisibilityBase {
    uint256 private x = 0;
    uint256 internal y = 1;
    uint256 public z = 2;

    function privateFunc() private pure returns (uint256) {
        return 0;
    }

    function internalFunc() internal pure returns (uint256) {
        return 100;
    }

    function publicFunc() public pure returns (uint256) {
        return 200;
    }

    function externalFunc() external pure returns (uint256) {
        return 300;
    }

    function examples() external view {
        x + y + z;
        privateFunc();
        internalFunc();
        publicFunc();
        // externalFunc(); // 正常的调用方式无法调用
        this.externalFunc(); // 使用this关键字可以访问。原理是到合约外部访问。但浪费gas
    }
}

contract VisibilityChild is VisibilityBase {
    function examples2() external view {
        // x; 内部的不能继承访问
        y + z;
        internalFunc();
        publicFunc();
        // externalFunc(); 仅允许外部调用
        // this.externalFunc();
        // 虽然是继承。但是也不能重写external关键字修饰的外部函数
    }
}
