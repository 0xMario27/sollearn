// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

/*
合约的自毁
selfdestruct
主要有两个功能：
1、删除合约
2、强制发送主币到一个地址
*/

contract Kill {
    /*
    方便测试，在测试的时候利用构造函数将主币传递到合约中。
    这样在自毁的时候就会返回给我们主币。
    */
    constructor() payable {}

    function kill() external {
        /*
        自毁合约
        将合约剩余的主币发送到指定的地址上。（是一种强制发送）
        如果msg.sender是一个合约，但是这个合约没有接收主币的回退函数，也依然会发送成功。
        */

        selfdestruct(payable(msg.sender));
    }

    // 测试函数，当这个合约自毁成功之后，该函数将无法调用成功。
    function testCall() external pure returns (uint256) {
        return 123;
    }
}

contract Helper {
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function kill(Kill _kill) external {
        _kill.kill();
    }
}
