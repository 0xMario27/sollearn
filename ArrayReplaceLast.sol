// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

// 如果不需要严格保证原数组的元素顺序。那么可以采用替换的形式来处理数组元素删除的操作。

contract ArrayReplaceLast {
    uint256[] public arr;

    // [1, 2, 3, 4] => remove(1) => [1, 4, 3]
    // [1, 4, 3] => remove(2) => [1, 4]
    function remove(uint256 _index) public {
        require(_index < arr.length);
        arr[_index] = arr[arr.length - 1];
        arr.pop();
    }

    function test() external {
        arr = [1, 2, 3, 4];
        remove(1);
        assert(arr.length == 3);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        assert(arr[2] == 3);

        remove(2);
        assert(arr.length == 2);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
    }
}
