// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 代理
// 通过合约来部署合约(部署合约)

contract TestContract1 {
    address public owner = msg.sender;

    function setOwner(address _owner) public {
        require(msg.sender == _owner, "not owner");
        owner = _owner;
    }
}

contract TestContract2 {
    address public owner = msg.sender;
    uint256 public value = msg.value;
    uint256 public x;
    uint256 public y;

    constructor(uint256 _x, uint256 _y) payable {
        x = _x;
        y = _y;
    }
}

contract Proxy {
    // payable 可以发送主币
    // 事件，通过这个事件向链外汇报这个新部署合约的地址
    event Deploy(address);

    fallback() external payable {}

    function deploy(bytes memory _code)
        external
        payable
        returns (address addr)
    {
        // address addr; 直接使用隐式返回
        // 但只能部署TestContract1，如果想部署TestContract2，就需要改代码。
        // new TestContract1();

        // 内联汇编
        assembly {
            // create(v, p, n)
            // v = amount of ETH to send 代表部署合约发送的以太坊主币的数量
            // p = pointer in memory to start of code 代表内存中机器码开始时的位置
            // n = size of code 代表着内存中机器码整个的大小
            // callvalue() = msg.value 在内联汇编中不可以使用msg

            addr := create(callvalue(), add(_code, 0x20), mload(_code))
        }
        // return addr;
        require(addr != address(0), "deploy failed");
        emit Deploy(addr); // 触发事件
    }

    function execute(address _target, bytes memory _data) external payable {
        (bool success, ) = _target.call{value: msg.value}(_data);
        require(success, "failed");
    }
}

contract Helper {
    function getBytecode1() external pure returns (bytes memory) {
        // 获取部署合约所需要的机器码
        bytes memory bytecode = type(TestContract1).creationCode;
        return bytecode;
    }

    function getBytecode2(uint256 _x, uint256 _y)
        external
        pure
        returns (bytes memory)
    {
        // 因为TestContract2有构造函数和参数。
        // 构造函数的参数就是连接部署合约的bytecode之后的一段十六进制数
        // 所以通过打包的形式连接在TestContract2的bytecode之后形成新的bytecode

        bytes memory bytecode = type(TestContract2).creationCode;
        return abi.encodePacked(bytecode, abi.encode(_x, _y));
    }

    function getCallData(address _owner) external pure returns (bytes memory) {
        // 调用设置管理员的方法
        return abi.encodeWithSignature("setOwner(address)", _owner);
    }
}
// 疑问
// 1、内联汇编
