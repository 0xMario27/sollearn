// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

contract LocalVariables {
    uint256 public i;
    bool public b;
    address public myAddress;

    function foo() external {
        // 只定义了局部变量。所以下列代码不会更新到链上。
        uint256 x = 123;
        bool f = false;
        x += 456;
        f = true;

        // 操作了状态变量，数据会写入链上。
        i = 123;
        b = true;
        myAddress = address(1);
    }
}
