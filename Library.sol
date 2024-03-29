// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
库合约，可以节省代码量的做法？
*/

library Math {
    function max(uint256 x, uint256 y) internal pure returns (uint256) {
        return x >= y ? x : y;
    }
}

contract Test {
    function testMax(uint256 x, uint256 y) external pure returns (uint256) {
        return Math.max(x, y);
    }
}

library ArrayLib {
    function find(uint256[] storage arr, uint256 x)
        internal
        view
        returns (uint256)
    {
        for (uint256 i = 0; i < arr.length; i++) {
            if (arr[i] == x) {
                return i;
            }
        }
        revert("not found");
    }
}

// 第一种使用库合约的方法
contract TestArray {
    uint256[] public arr = [3, 2, 1];

    function testFind() external view returns (uint256 i) {
        return ArrayLib.find(arr, 2);
    }
}

// 第二种使用库合约的方法
contract TestArray2 {
    /*
    相当于把库合约ArraryLib挂载到了uint[]类型上。
    这样uint[]的类型就有了ArraryLib的库方法。
    */
    using ArrayLib for uint256[];
    uint256[] public arr = [3, 2, 1];

    function testFind() external view returns (uint256 i) {
        // return ArrayLib.find(arr, 2);
        return arr.find(2);
    }
}
