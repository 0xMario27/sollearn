// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ValueTypes {
    bool public b = true;
    uint public u = 123;  // default bit 256 max value=2**256-1
    int public i = -123;  // default bit 256 max value between -2**255 and 2**255-1

    int public minInt = type(int).min;  // 有符号整数类型的最小值。
    int public maxInt = type(int).max;  // 有符号整数类型的最大值。

    // 最特别的数据类型，地址address 是一个十六进制数字。比较短的十六进制数字。
    // 是利用私钥，公钥等算出来的地址。
    address public addr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;  // 520786028573372002406822046668826248860828644644
    // bytes 最大32位
    bytes32 public b32 = 0x89c58cedBa9078bdef2bb60f22e58eeff7dbfed6c2dff3e7c508b629295926fa;  // 比地址还大一些

  }