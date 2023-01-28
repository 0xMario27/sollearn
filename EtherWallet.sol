// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
实现一个以太坊的钱包。
通过这个钱包我们可以向合约中存放主币。
也可以随时从合约中取出主币。
*/

contract EtherWallet {
    /*
任何人都可以向合约中发送主币
但是只有管理员可以从合约中取出主币
*/
    address payable public immutable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    // 只用来接受主币。不用来接受不存在的函数。所以不使用fallback
    receive() external payable {}

    function withdraw(uint256 _amount) external {
        require(msg.sender == owner, "caller is not owner");
        owner.transfer(_amount);
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}

/*
两种节约gas的方式。
1、使用immutable定义owner。
2、使用内存中的数据代替状态变量。比如使用msg.sender代替withdraw中的owner。
*/
