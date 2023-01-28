// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
合约调用其他合约的几种方法
*/

contract CallTestContract {
    // 第一种方法
    function setX(address _test, uint256 _x) external {
        TestContact(_test).setX(_x);
    }

    // 第二种方法
    function setX2(TestContact _test, uint256 _x) external {
        _test.setX(_x);
    }

    // 只读函数
    function getX(address _test) external view returns (uint256) {
        uint256 x = TestContact(_test).getX();
        return x;
    }

    // 接受主币的函数调用其他合约接受主币的函数
    function setXandSendEther(address _test, uint256 _x) external payable {
        // {value: msg.value} 这部分难道是calldata？
        TestContact(_test).setXandReceiveEther{value: msg.value}(_x);
    }

    // 只读函数且返回多个值
    function getXandValue(address _test)
        external
        view
        returns (uint256, uint256)
    {
        (uint256 x, uint256 value) = TestContact(_test).getXandValue();
        return (x, value);
    }
}

contract TestContact {
    uint256 public x;
    uint256 public value = 123;

    function setX(uint256 _x) external {
        x = _x;
    }

    function getX() external view returns (uint256) {
        return x;
    }

    function setXandReceiveEther(uint256 _x) external payable {
        x = _x;
        value = msg.value; // 当前这个函数接受到的主币的数量
    }

    function getXandValue() external view returns (uint256, uint256) {
        return (x, value);
    }
}
