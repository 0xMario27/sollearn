// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 数组是可以遍历元素的
// 映射是可以直接找到对应的地址对应的值的
// 映射是不能便利的
contract IterableMapping {
    mapping(address => uint256) public balances; // 真正的主数据
    mapping(address => bool) public inserted; // 是否可以不需要这个结构
    address[] public keys;

    // 实现既可以查找，又可以遍历的方法。也就是可迭代的映射。
    function set(address _key, uint256 _val) external {
        balances[_key] = _val;
        if (!inserted[_key]) {
            inserted[_key] = true;
            keys.push(_key);
        }
    }

    function getSize() external view returns (uint256) {
        return keys.length;
    }

    function first() external view returns (uint256) {
        return balances[keys[0]];
    }

    function last() external view returns (uint256) {
        return balances[keys[keys.length - 1]];
    }

    function get(uint256 _i) external view returns (uint256) {
        require(_i < keys.length);
        return balances[keys[_i]];
    }
}
