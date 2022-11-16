// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

contract SimpleStorage {
    string public text; // 因为是公开可视，所以默认有读取方法

    // external 外部可视，合约内部的函数不能调用它。
    // 在相同参数值的情况下 calldata和 memory的gas消耗是有区别的。前者略小于后者。
    function set(string calldata _text) external {
        text = _text;
    }

    function get() external view returns (string memory) {
        // 相当于智能合约将状态变量拷贝到内存中返回的。
        return text;
    }
}
