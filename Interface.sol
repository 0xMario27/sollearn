// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

/*
    接口
    如果我们不知道另一个合约的原代码，
    或者另一个合约的原代码特别的庞大。
    也是为了调用其他合约的函数用的。
    只是可以透明的把另一个合约的结构表达出来。
*/

/*
    假设该合约的代码不知道的情况下
    对应文件目录 Counter.sol
contract Counter {
    uint256 public count;

    function inc() external {
        count += 1;
    }

    function dec() external {
        count -= 1;
    }
}
*/

// 实现接口
interface ICounter {
    // 因为在Counter的合约中。count变量是public的状态变量。编译器自带一个可读函数。
    function count() external view returns (uint256);

    function inc() external;
}

contract CallInterface {
    /*
        合约也可以用address类型变量接收,
        也就是合约在链上是以一个地址对象存在的？
    */
    uint256 public count;

    function examples(address _counter) external {
        ICounter(_counter).inc();
        count = ICounter(_counter).count();
    }
}
