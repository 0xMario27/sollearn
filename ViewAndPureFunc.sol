// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// view: 与pure比较类似。都是只读方法。但是前者会读取一些变量的值。
// 比如状态变量或全局变量。而后者pure是只能读取局部变量的。不能读取全局变量和状态变量。只能读区局部变量。
contract ViewAndPureFcuntions {
    uint256 public num; // 状态变量

    function viewFunc() external view returns (uint256) {
        // 读了链上的信息就需要用view关键字修饰。
        return num;
    }

    function pureFunc() external pure returns (uint256) {
        return 1;
    }

    // 如下两个函数。应该使用什么修饰关键字呢？
    function addToNum(uint256 x) external view returns (uint256) {
        return num + x;
    }

    function add(uint256 x, uint256 y) external pure returns (uint256) {
        return x + y;
    }
}
