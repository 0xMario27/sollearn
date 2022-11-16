// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

// 映射
// 声明：分为简单声明和嵌套声明
// 相关的操作。设置，获取，删除等

contract Mapping {
    mapping(address => uint256) public balances; //简单声明
    mapping(address => mapping(address => bool)) public isFriend; // 嵌套声明

    function examples() external {
        balances[msg.sender] = 123;
        // 获取
        uint256 bal = balances[msg.sender];
        uint256 bal2 = balances[address(1)]; // 所有类型都有默认值。所以这里没有对应的数据返回的是默认值0
        // 修改
        balances[msg.sender] += 456; // 123+456=579
        // 删除
        delete balances[msg.sender]; // 恢复到默认值。而不是真正的删除

        //this是当前合约的地址。所以在智能合约中，智能合约也是有地址的
        // 猜测应该所有的对象都是有地址的
        isFriend[msg.sender][address(this)] = true;
    }
}
