// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

// 常量的意义。可以减少gas的消耗。
// 在正常的读取方法中，是不消耗gas的。
// 但是如果在一个写入方法中调用了常量就需要按照对应的收取gas了。
// 而常量的gas比同等的变量的gas小。

contract Constants {
    uint256 public constant MY_UINT = 123;
    // gas 21442
    address public constant MY_ADDRESS = 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;
}

contract Vars {
    // gas 23553
    address public MY_ADDRESS = 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;
}
