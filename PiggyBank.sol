// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

/*
可以通过任何人地址向以太坊发送主币。
存钱罐的拥有者可以取出主币。
*/
contract PiggyBank {
    address public owner = msg.sender;
    event Deposit(uint256 amount);
    event Withdrwa(uint256 amount);

    receive() external payable {
        emit Deposit(msg.value);
    }

    function withdraw() external {
        require(msg.sender == owner, "not owner");
        emit Withdrwa(address(this).balance);
        selfdestruct(payable(msg.sender));
    }
}
