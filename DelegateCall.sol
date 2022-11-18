// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

/*
委托调用: B 是被委托人。充当委托人。
两种调用的状态区别
A calls B sends 100 wei
        B calls C sends 50 wei
A ----> B ----> C
                msg.sender = B
                msg.value = 50
                execute code on C's state variables
                use ETH in C


A calls B, sends 100 wei
        B delegatecall C
A ----> B ----> C
                msg.sender = A
                msg.value = 100
                execute code on B's state variables
                use ETH in B

委托调用的情况下，C合约是不能保存主币的值的。值在B中保存。
也就是说C的状态变量并不能全部都更新的。而且也不能修改。
*/
contract TestDelegateCall {
    uint256 public num;
    address public sender;
    uint256 public value;

    function setVars(uint256 _num) external payable {
        num = 2 * _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract DelegateCall {
    /*
        顺序必须和被调用合约的定义相同。
        如果需要在被调用合约中添加新的状态变量，那么应该在最后追加。而不能插队。
    */
    uint256 public num;
    address public sender;
    uint256 public value;

    function setVars(address _test, uint256 _num) external payable {
        // _test.delegatecall(abi.encodeWithSignature("setVars(uint256)", _num));
        // 另一种
        (bool success, bytes memory data) = _test.delegatecall(
            abi.encodeWithSelector(TestDelegateCall.setVars.selector, _num)
        );
        require(success, "delegatecall failed");
    }
}
/*
只能通过使用被调用函数的对应逻辑来改变当前委托合约的状态变量的值。
比如在被调用合约中修改了处理num的逻辑。那么相当于实现了一个可升级合约的能力。
*/
