// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

/*
哈希算法
*/

contract HashFunc {
    function hash(
        string memory text,
        uint256 num,
        address addr
    ) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(text, num, addr)); // encodePacked和encode两种打包方法。
    }

    // 演示两种不同的打包编码方式的差别。
    function encode(string memory text0, string memory text1)
        external
        pure
        returns (bytes memory)
    {
        // 不定长需要memory
        return abi.encode(text0, text1);
    }

    function encodePacked(string memory text0, string memory text1)
        external
        pure
        returns (bytes memory)
    {
        // 不定长需要memory
        return abi.encodePacked(text0, text1);
    }

    /*
    encode的形式会在编码后补0对齐。
    encodePacked不会补0，而是压缩率更高。但不补0可能会导致一些漏洞出现。
    比如"AAAA","BBB"和"AAA","ABBB"对于encodePacked的压缩方式结果是相同的。
    所以不同的数据产生了相同的hash结果。或者说相同的编码结果。
    */
    function collision(string memory text0, string memory text1)
        external
        pure
        returns (bytes32)
    {
        return keccak256(abi.encodePacked(text0, text1));
    }

    /*
    有两种解决这种问题的方式：
    1、使用encode编码形式去计算hash。
    2、使用数字或其他类型的数据放在两个字符串数据中间隔离开。
    */
}
