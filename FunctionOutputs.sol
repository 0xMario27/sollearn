// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

// 三种函数返回值形式
contract FunctionOutputs {
    // 使用了public而不是external
    // 因为需要合约中的其他函数还能够调用该函数
    // 公开可视范围的意思是内部和外部都可以调用

    // 返回值只知道类型，但是不知道含义。所以还可以给返回值命名, golang?
    function returnMany() public pure returns (uint256, bool) {
        return (1, true);
    }

    function named() public pure returns (uint256 x, bool b) {
        return (1, true);
    }

    function assigned() public pure returns (uint256 x, bool b) {
        // 隐式返回
        x = 1;
        b = true;
    }

    function destructingAssigments() public pure {
        (uint256 x, bool b) = returnMany(); // 相当于解包
        (, bool bs) = returnMany(); // 可以忽略部分返回值，这样可以节省gas
    }
}
// 对于gas的理解暂时感觉就好像是内存资源一样。也需要去权衡一个最合适的资源利用率。虽然付款的是自己。
