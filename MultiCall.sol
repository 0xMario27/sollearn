// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
多重呼叫的解决方案
对一个或多个合约的多次函数调用打包整合在一个交易中，对合约再进行调用。
对链的调用有次数限制
*/
contract TestMultiCall {
    /*
    如果需要func1和func2的调用都返回相同的区块时间。
    由于网络延迟可能会不相同。
    MultiCall合约可以
    */
    function func1() external view returns (uint256, uint256) {
        return (1, block.timestamp);
    }

    function func2() external view returns (uint256, uint256) {
        return (2, block.timestamp);
    }

    function getData1() external pure returns (bytes memory) {
        return abi.encodeWithSelector(this.func1.selector);
    }

    function getData2() external pure returns (bytes memory) {
        return abi.encodeWithSelector(this.func2.selector);
    }
}

contract MultiCall {
    function multiCall(address[] calldata targets, bytes[] calldata data)
        external
        view
        returns (bytes[] memory)
    {
        require(targets.length == data.length, "target length != data length");
        bytes[] memory results = new bytes[](targets.length);

        for (uint256 i; i < targets.length; i++) {
            /*
            静态调用: 对目标地址进行静态调用，而不是用过底层的call。底层call会产生动态的底层写入方法。
            因为使用了view签名了函数，所以需要使用静态的函数调用。
            */
            (bool success, bytes memory result) = targets[i].staticcall(
                data[i]
            );
            require(success, "call failed");
            results[i] = result;
        }

        return results;
    }
}
