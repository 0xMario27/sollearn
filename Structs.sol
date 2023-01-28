// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 可以把多种数据结构打包在一起的数据类型

contract Structs {
    struct Car {
        string model;
        uint256 year;
        address owner;
    }
    // 状态变量，全部都保存在链上。
    Car public car;
    Car[] public cars;
    mapping(address => Car[]) public carsByOwner;

    function examples() external {
        // 在这里的是局部变量，保存在内存中。

        // 三种声明和初始化结构体的方法
        // 1
        Car memory toyota = Car("Toyota", 1990, msg.sender); // memory标记变量在内存中。运行结束后该变量会被释放。
        // 2
        Car memory lambo = Car({
            model: "Lamborghini",
            year: 1980,
            owner: msg.sender
        });
        // 3
        Car memory tesla;
        tesla.model = "Tesla";
        tesla.year = 2010;
        tesla.owner = msg.sender;
        // 推入数组
        cars.push(toyota);
        cars.push(lambo);
        cars.push(tesla);

        cars.push(Car("Ferrari", 2020, msg.sender)); // 该结构体也是存在于内存中然后推入到数组中的
        // 获取结构体中的值
        Car memory _car = cars[0];
        _car.model;
        _car.year;
        _car.owner;

        // 如果读取到存储storage中，就可以针对结构体的值进行修改和删除的操作。
        // 内存中的是不可以修改和删除的。
        // 存储相当于我们把状态变量读取出来。并且是带有指针的读取。
        Car storage _car2 = cars[1];
        _car2.year = 1999; // 这样状态变量的值也被修改了。链上(合约中)的数据也就同样被修改了。

        // 删除
        // 同样的，删除也是恢复了默认值。
        delete _car2.owner;
        delete cars[1]; // 恢复了整个对应的Car结构体三个元素的默认值。
    }
}
// 疑问
// 1、storage是针对所有的状态变量进行修改的么。还是只是针对结构题。之前普通变量好像可以直接修改。
