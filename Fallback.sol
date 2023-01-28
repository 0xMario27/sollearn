// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
回退函数，在智能合约中有两个功能：
1、当调用的函数在合约中不存在的时候。
2、直接向合约中发送以太坊主币的时候。
当出现上述情况时，会调用对应的回退函数。

回退函数在Solidity 0.8.x中有两种写法，分别对应两种不同的功能。
*/
/*
fallback() or receive()?
     Ether is sent to contract
            |
     is msg.data empty?
        |           \
       yes          no
       |             \
receive() exists?   fallback()
    |        \
   yes        no
   |           \
receive()   fallback()
*/
contract Fallback {
    event Log(string func, address sender, uint256 value, bytes data);

    /*
    第一种写法。不需要function，直接fallback。
    它只能接受当调用智能合约中不存在的函数的时候，
    收到的触发。 

    当加入payable关键字的时候，就可以接收到主币
    的直接发送了。
    */
    fallback() external payable {
        emit Log("fallback", msg.sender, msg.value, msg.data);
    }

    /*
    第二种写法。为了直接只接受主币的发送的一种写法。
    必须加入payable关键字。但如果不存在receive函数，
    那么就会执行fallback函数（相当于一个备用函数）。
    */
    receive() external payable {
        emit Log("receive", msg.sender, msg.value, ""); // receive函数是不接受数据的。所以没有msg.data
    }
}
