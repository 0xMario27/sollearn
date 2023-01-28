// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
ERC20 标准合约
Token
*/

interface IERC20 {
    // 代表着当前合约的token总量
    function totalSupply() external view returns (uint256);

    // 代表某一个账户的当前余额
    function balanceOf(address account) external view returns (uint256);

    // 把当前账户的余额又调用者发送到recipient账户
    // 是标准的写入方法。所以还会对外上报一个Transfer事件。
    // 通过Transfer事件就能看到token的流转了。
    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    // 批准，把调用账户的数量批准给另一个账户，然后通过allowance可以查询某一个账户对另一个账户的批准额度
    function approve(address spender, uint256 amount) external returns (bool);

    // 当向另一个合约存款的时候，另一个合约必须调用transferFrom才能把我们账户中的Token拿到它的合约中。
    // transferFrom和approve也是联合使用的。
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 amount
    );
}

// 实现标准合约
contract ERC20 is IERC20 {
    // 用于表明当前合约的tokne总量
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    string public name = "Test";
    string public symbol = "TEST";
    uint8 public decimals = 18;

    function transfer(address recipient, uint256 amount)
        external
        returns (bool)
    {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function mint(uint256 amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint256 amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}
