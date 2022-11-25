// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

/*
函数签名(函数选择器)
其实就是描述一个函数的所有关键字的集合。
与Golang的函数签名一致的概念。
用来代表一个智能合约的虚拟机是如何找到函数的
*/

contract FunctionSelector {
    function getSelector(string calldata _func) external pure returns (bytes4) {
        return bytes4(keccak256(bytes(_func)));
    }
    // getSelector("transfer(address,uint256)") == 0xa9059cbb
}

contract Receiver {
    event Log(bytes data);

    /*
    呼叫一个函数的数据主要有两部分
    第一部分：函数的选择器，也叫函数的签名
    0xa9059cbb
    第二部分：参数
    0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc4
    000000000000000000000000000000000000000000000000000000000000007b
    */
    function transfer(address _to, uint256 _amount) external {
        emit Log(msg.data);
    }
}
/*
如上特性可知，函数是可以同名的，只要同名的函数的参数不同类型即可。
相当于实现了重载能力。
*/
