// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 数据的存储位置，可以是 storage, memory, calldata
// 存储在storage上的是状态变量
// 存储在memory的是局部变量
// calldata和memory比较类似，但是只能用在输入的参数中

contract DataLocations {
    struct MyStruct {
        uint256 foo;
        string text;
    }

    mapping(address => MyStruct) public myStructs;

    function examples() external {
        myStructs[msg.sender] = MyStruct({foo: 123, text: "bar"});
        MyStruct storage myStruct = myStructs[msg.sender];
        // 状态变量会改变。下一次读取合约的时候这个状态变量的值就能看到修改成功了
        myStruct.text = "foo";

        // 也是可以修改这个变量的值的。但是在函数调用结束之后就消失了。并不会被记录在链上。
        // 很像局部变量的状态
        MyStruct memory readOnly = myStructs[msg.sender];
    }

    // 在函数的参数中，如果使用了数组这样的变量类型。
    // 就必须定义内存的存储类型或者是calldata的存储类型
    // 字符串类型和bytes类型也需要当成数组来对待。因为他们底层也是数组。
    // 在returns中。如果返回的是结构体、数组、字符串、bytes等也需要加存储位置。
    function examples2(uint256[] memory y, string memory s)
        external
        returns (uint256[] memory)
    {
        myStructs[msg.sender] = MyStruct({foo: 123, text: "bar"});
        MyStruct storage myStruct = myStructs[msg.sender];
        // 状态变量会改变。下一次读取合约的时候这个状态变量的值就能看到修改成功了
        myStruct.text = "foo";

        // 也是可以修改这个变量的值的。但是在函数调用结束之后就消失了。并不会被记录在链上。
        // 很像局部变量的状态
        MyStruct memory readOnly = myStructs[msg.sender];
        // 内存中的数组只能是定长数组。
        // 局部变量也必须是定长数组。
        uint256[] memory memArr = new uint256[](3);
        memArr[0] = 234;
        return memArr; // 就可以把我们定义的局部变量返回到链外了
    }

    // calldata只能用在函数的输入参数中
    // 这里的calldata的解释需要配合下面的私有函数一起看
    // 例 examples3 as A call _internal as B
    // 如果A的参数有calldata类型。且同样传递给了B的calldata类型。那么是可以直接传递的。有点传递引用的意思。
    // 如果A的参数是calldata但是B的对应参数是memory的。那么会隐式将calldata转换成memory。这样会浪费很多的gas。

    function examples3(uint256[] calldata y)
        external
        returns (uint256[] memory)
    {
        _internal(y);
    }

    function _internal(uint256[] calldata y) private {
        uint256 x = y[0];
    }
}
