// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

// 数组的操作
contract ArrayShift {
    uint256[] public arr;

    function example() public {
        arr = [1, 2, 3];
        delete arr[1];
    }

    // delete方法的删除只能将对应索引位置的值重置为默认值。但是并不会删除实际给数组。
    // 需要实现一个方法可以在删除之后实现数组位置的退还。
    // [1, 2, 3] => remove(1) => [1, 3, 3] => [1, 3]
    // [1, 2, 3, 4, 5, 6] => remove(2) => [1, 2, 4, 5, 6, 6] => [1, 2, 4, 5, 6]
    // [1] => remove(0) => [1] => []

    // 通过移动位置来删除数组中指定元素的方法
    // 该方案的优点是可以保持原数组的顺序，缺点是比较浪费gas
    function remove(uint256 _index) public {
        // 应该也不能小于0
        require(_index < arr.length, "index out of bound");
        for (uint256 i = _index; i < arr.length - 1; i++) {
            arr[i] = arr[i + 1];
        }
        arr.pop();
    }

    function test() external {
        arr = [1, 2, 3, 4, 5];
        remove(2);
        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 4);
        assert(arr[3] == 5);
        assert(arr.length == 4);

        arr = [1];
        remove(0);
        assert(arr.length == 0);
    }
}
