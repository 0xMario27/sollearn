// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

/*
    低级调用另一个合约的方法
    使用call函数调用。
    在SendEth.sol的发送主币代码中使用过。
*/

contract TestCall {
    string public message;
    uint256 public x;

    event Log(string message);

    fallback() external payable {
        emit Log("fallback was called");
    }

    function foo(string memory _message, uint256 _x)
        external
        payable
        returns (bool, uint256)
    {
        message = _message;
        x = _x;
        return (true, 999);
    }
}

contract Call {
    /*
    前面讲述了两种调用的方法。
    一种是通过合约的源码调用。
    另一种是通过接口的描述进行调用。
    */
    bytes public data;

    // payable 对于该函数的修饰也是必要的。因为使用了_test.call{value: 111, gas: 5000}发送主币。
    function callFoo(address _test) external payable {
        /*
        如果使用gas: 5000去调用foo的话。5000的gas是不够修改foo函数中的两个变量的。
        如果想让这个生效。需要删除gas: 5000，让合约自动扣除。 
        */
        (bool success, bytes memory _data) = _test.call{value: 111, gas: 5000}(
            abi.encodeWithSignature("foo(string,uint256)", "call foo", 123)
        );
        require(success, "call failed");
        data = _data;
    }

    function callDoesNotExist(address _test) external {
        /*
        如果被调用的合约中没有fallback函数。那么解释器会直接报错。
        如果有fallback函数。那么会执行fallback函数的内容。
        具体的调用流程可以参考Fallback.sol中的流程。
        */
        (bool success, ) = _test.call(
            abi.encodeWithSignature("doesNotExist()")
        );
        require(success, "call failed");
    }
}
