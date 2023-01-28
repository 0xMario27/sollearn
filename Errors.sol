// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 报错的控制（异常控制）
// 在智能合约中有常见的3种异常控制方法。
// require:
// revert:
// assert:
// 以上三种异常处理。都会退还gas费用，状态回滚的特性。
// 0.8.x的版本。新增了自定义错误的特性。可以节约gas。
contract Errors {
    function testRequire(uint256 _i) public pure {
        require(_i <= 10, "i > 10");
        // code...
    }

    function testRevert(uint256 _i) public pure {
        // revert不可以包含表达式。
        if (_i > 10) {
            revert("i > 10");
        }
        // code...
    }

    uint256 public num = 123;

    function testAssert() public view {
        // assert 不包含报错信息
        assert(num == 123);
        // code...
    }

    function foo(uint256 _i) public {
        num += 1;
        // 当_i大于10时，就算已经执行了 num+=1，依旧会回滚状态。并且退还gas
        require(_i < 10);
    }

    // 0.8.x新增的自定义错误
    error MyError(address caller, uint256 i);

    function testCustomError(uint256 _i) public view {
        // 如果使用require提示很长的字符串的话，会消耗大量的gas
        // require(_i < 10, "error error error error error error error ");

        // 使用自定义错误节省gas
        if (_i > 10) {
            // msg.sender 是全局变量。所以需要使用view关键字
            revert MyError(msg.sender, _i); // 使用revert触发自定义错误
        }
    }
}
