// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//全局变量：不需要定义就能显示内容的变量。往往记录链上的信息或账户的信息。
contract GlobalVariables {
    // view: 与pure比较类似。都是只读方法。但是前者会读取一些变量的值。
    // 比如状态变量或全局变量。而后者pure是智能读取变量的。不能读取全局变量和状态变量。只能读区局部变量。
    function globalVars()
        external
        view
        returns (
            address,
            uint256,
            uint256
        )
    {
        // msg.xxx  // msg账户的内容
        // .sender指调用这个函数的地址。是指上一个调用它的地址。有可能是个人。
        // 还有可能是另一个合约
        address sender = msg.sender; // sender是个局部变量

        // 区块的时间戳。因为这个函数是只读的，所以这个时间戳就是按下按钮的时间戳。
        // 如果是写入的方法，那显示的就是出块的时间。并不是真正的时间
        uint256 timestamp = block.timestamp;

        // 指当前的区块号。
        uint256 blockNum = block.number;
        return (sender, timestamp, blockNum);
    }
}
