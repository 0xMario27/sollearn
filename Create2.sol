// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
通过合约部署合约
相似的New.sol
是用工厂合约的地址加一个盐去计算未来新的合约的地址，
所以新的地址在部署之前就可以被预测出来
*/

contract DeployWithCreate2 {
    address public owner;

    constructor(address _owner) {
        owner = _owner;
    }
}

contract Create2Factory {
    event Deloy(address addr);

    /*
    使用的salt的时候因为生成的新的合约的地址是根据salt生成的。
    所以相同的盐在该工厂合约中只能使用一次。否则就会导致重复部署合约的错误。
    如果新生成的合约带自毁功能的，当新合约自毁之后，使用相同的盐是可以将新的合约再部署到原来的地址上。
    */
    function deploy(uint256 _salt) external {
        DeployWithCreate2 _contract = new DeployWithCreate2{
            salt: bytes32(_salt)
        }(msg.sender);
        emit Deloy(address(_contract));
    }

    // 计算新的合约地址的逻辑
    function getAddress(bytes memory bytecode, uint256 _salt)
        public
        view
        returns (address)
    {
        bytes32 hash = keccak256(
            abi.encodePacked(
                bytes1(0xff),
                address(this),
                _salt,
                keccak256(bytecode)
            )
        );
        return address(uint160(uint256(hash)));
    }

    // 生成bytecode机器码的逻辑
    function getBytecode(address _owner) public pure returns (bytes memory) {
        bytes memory bytecode = type(DeployWithCreate2).creationCode;
        return abi.encodePacked(bytecode, abi.encode(_owner));
    }
}
