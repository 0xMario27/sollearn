// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

contract DefaultValues {
    // 状态变量和局部变量。都有默认值。
    // 在没有赋值之前。他们都是默认值存在。
    bool public b; // false
    uint256 public u; // 0
    int256 public i; // 0
    address public a;
    bytes32 public b32;
}
