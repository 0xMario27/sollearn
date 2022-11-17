// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

// 继承
// 如果父合约有构造函数的情况
// 两种输入构造函数参数的方法，但其实两种是可以混合使用的
// 构造函数运行的顺序

contract S {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

contract T {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

// 第一种实现方法。直接相当于创建实例的方式 S("s"), T("t")
// 这种情况下是已知这两个参数的内容的前提下
// 也就是无法在调用构造函数的对参数进行动态赋值
contract U is S("s"), T("t") {

}

// 第二种实现方法是实现一个自己的构造函数并把值传递上去。
// 写法有些类似 function modifier

// 该构造函数的运行顺序是 S T V
contract V is S, T {
    constructor(string memory _name, string memory _text) S(_name) T(_text) {}
}

// 第三种还可以将这两种情况混合使用
contract VV is S("s"), T {
    constructor(string memory _text) T(_text) {}
}
// 至于多重继承之后，构造函数的初始化顺序是根据合约定义的时候的继承顺序决定的
// 而不是由实际传递参数值的时候决定的
