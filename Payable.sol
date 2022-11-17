// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

/*
如果在智能合约的函数中，使用payable关键字标记，
那么代表着该函数可以接受以太坊主币的传入。
如果不标记，那么在传入以太坊主币的时候就会报错。

也可以对变量进行payable标记。
比如对address变量使用payable标记，
代表着该地址就可以发送以太坊主币了。
*/

contract Payable {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    // 不知道为什么不需要写具体的函数内容就可以支付主币?
    /*
    在部署的时候。这个部署账户是msg.sender，但是合约也有地址。
    部署之后的合约地址假设为x。
    那么支付的流程就是from msg.sender to x
    */
    function deposit() external payable {}

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
