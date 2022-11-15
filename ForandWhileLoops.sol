// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

contract ForAndWhileLoops {
    function loops() external pure {
        for (uint256 i = 0; i < 10; i++) {
            // code...
            if (i == 3) {
                continue;
            }
            if (i == 5) {
                break;
            }
            // more code...
        }
        uint256 j = 0;
        while (j < 10) {
            // 智能合约中是不可以执行无限循环的。
            j++;
        }
    }

    function sum(uint256 _n) external pure returns (uint256) {
        // 在智能合约中。需要控制循环的次数。因为会导致高昂的gas费用。
        uint256 s;
        for (uint256 i = 1; i <= _n; i++) {
            s += i;
        }
        return s;
    }
}
