// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 事件
// 一种记录当前智能合约运营状态的方法，但并不记录在状态变量中。
// 体现在区块链浏览器上或者交易记录的logs里。
// 通过事件可以查询到一些我们改变过的状态。

// 如果只是单纯的消息调用，可以用状态变量记录，也可以用事件记录。
// 但是事件更加节约gas

contract Event {
    event Log(string message, uint256 val); // 定义事件
    // indexed关键字：被该关键字标记的变量就可以被在链外进行搜索查询了。
    // 普通的事件可以有很多的参数。
    // 但是有索引的变量最多有三个。
    event IndexedLog(address indexed sender, uint256 val);

    // 虽然没有读取或者写入状态变量，但也是一个写入方法。所以不能用view或pure关键字。
    // view或pure只标记在只读方法中。
    // 因为它确实也改变了链上的状态。
    function examples() external {
        emit Log("foo", 123); // 触发事件
        emit IndexedLog(msg.sender, 123);
    }

    event Message(address indexed _from, address indexed _to, string message);

    function sendMessage(address _to, string calldata message) external {
        emit Message(msg.sender, _to, message);
    }
}
