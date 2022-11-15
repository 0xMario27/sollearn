// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

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
}
