// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

/*
在智能合约中有三种方法发送主币
1、transfer: 会消耗2300gas，如果失败会reverts
2、send: 会消耗2300gas，会返回一个bool
3、call: 会消耗所有剩余的gas，会返回一个bool和data
*/

contract SendEth {
    // 两种方法来让合约可以存入主币

    // 方法一
    constructor() payable {} // 传入主币

    receive() external payable {} //接受主币

    function sendViaTransfer(address payable _to) external payable {
        /*
        使用transfer方法发送主币。
        如果发生异常，就会调用receive
        */
        _to.transfer(123);
    }

    function sendViaSend(address payable _to) external payable {
        /*
        使用send方法发送主币。
        */
        bool sent = _to.send(123);
        require(sent, "send failed");
    }

    function sendViaCall(address payable _to) external payable {
        /*
        使用call方法发送主币。
        call调用方式，就算_to没有payable属性。依旧可以发送主币
        */
        (bool success, ) = _to.call{value: 123}("");
        require(success, "call failed");
    }
}

// 接受主币发送的目标地址
contract EthReceiver {
    event Log(uint256 amount, uint256 gas);

    // 接受主币的函数
    receive() external payable {
        emit Log(msg.value, gasleft());
    }
}
