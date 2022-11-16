// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

// 数组
// 分为动态数组和固定长度的数组

// 介绍
// 数组的初始化
// 数组的操作
// 如何在内存中创建数组
// 通过函数返回数组

contract Array {
    // 定义动态数组
    uint256[] public nums; // 动态数组只能存在于状态变量中
    uint256[3] public numsFixed;
    // 初始化数组
    uint256[] public nums_ = [1, 2, 3];
    uint256[3] public numsFixed_ = [1, 2, 3];

    // 数组的操作
    function example() external {
        nums.push(4); // 对于变量的操作。都需要封装到function中
        uint256 x = nums[1]; // 取值
        nums[2] = 777; //替换
        delete nums[1]; // 不会修改原数组的长度。只会将删除的索引位置的值替换为默认值。uint的默认值为0
        nums.pop(); // 弹出数组的最后一个值。数组的长度会发生改变
        uint256 len = nums.length; // 获取数组的长度

        // 在内存中创建数组。这种变量属于局部变量
        // 首先需要指定memory关键字指定位置。内存数组是不允许使用动态数组的
        // 只可以使用定长数组。其中5就是定义的初始化长度。
        uint256[] memory a = new uint256[](5);
        // 改变长度的方法都不可以使用了，例如pop、push等
        a[0] = 1; // 可以修改指定索引位置的值
    }

    function returnArray() external view returns (uint256[] memory) {
        return nums;
    }
}
// 疑问
// 1、为什么返回数组需要memory关键字。还有一个calldata关键字。
