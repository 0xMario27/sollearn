// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 计数器的智能合约。可以对状态变量的增加和减少的操作。

contract Counter {
    // public：内部和外部都可以读取状态变量的值。
    // 外部：指的是只有外部可以读取。当前合约内部是不可以读取的。
    // 内部：当前合约。
    uint256 public count;

    // external: 外部可视只的是在合约的内部的其他函数是是不可以调用的。
    // 只能通过外部读取。
    function inc() external {
        // 因为这个函数是写入方法，所以不能有view或pure的关键词。
        // view 会读取状态变量。但不写状态变量。
        // pure 对状态变量不读不写，只有局部变量操作。
        count += 1;
    }

    function dec() external {
        count -= 1;
    }
}
