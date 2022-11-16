// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

// 枚举
// 布尔值只有两种状态，当我们想要使用多种状态的时候可以使用枚举
// 可以使一个变量有多种状态
contract Enum {
    // 枚举类型的默认值就是当前枚举元素的第一个值
    // 枚举中的值是按照索引的方式存在的，所以在设置的时候可以直接使用索引值。0为第一个。
    enum Status {
        None,
        Pending,
        Shipped,
        Completed,
        Rejected,
        Canceled
    }
    Status public status;

    struct Order {
        address buyer;
        Status status;
    }
    Order[] public orders;

    function get() public view returns (Status) {
        return status; // 返回的是当前状态所在位置的索引
    }

    function set(Status _status) external {
        // 比如这里的参数给0就是枚举的None
        status = _status;
    }

    function ship() external {
        status = Status.Shipped;
    }

    function reset() external {
        delete status; // 恢复到默认值，枚举类型的默认值就是当前枚举元素的第一个值
    }
}
