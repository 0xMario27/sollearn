// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
荷兰拍卖
普通拍卖模式是起拍价之后逐渐升高价格
荷兰拍：随着时间的流逝，价格会越来越低。
*/
interface IERC721 {
    function transferFrom(
        address _from,
        address _to,
        uint256 _nftId
    ) external;
}

contract DutchAuction {
    uint256 private constant DURATION = 7 days; //定义整个拍卖需要执行的时间周期
    IERC721 public immutable nft;
    uint256 public immutable nftId;
    address public immutable seller;
    uint256 public immutable startingPrice;
    uint256 public immutable startAt;
    uint256 public immutable expiresAt;
    uint256 public immutable discountRate;

    constructor(
        uint256 _startingPrice,
        uint256 _discountRate,
        address _nft,
        uint256 _nftId
    ) {
        seller = payable(msg.sender);
        startingPrice = _startingPrice;
        discountRate = _discountRate;
        startAt = block.timestamp;
        expiresAt = block.timestamp + DURATION;
        require(
            _startingPrice >= _discountRate * DURATION,
            "starting price < discount"
        );
        nft = IERC721(_nft);
        nftId = _nftId;
    }

    function getPrice() public view returns (uint256) {
        uint256 timeElapsed = block.timestamp - startAt;
        uint256 discount = discountRate * timeElapsed;
        return startingPrice - discount;
    }

    function buy() external payable {
        require(block.timestamp < expiresAt, "auction expired");
        uint256 price = getPrice();
        require(msg.value >= price, "ETH < price");
        nft.transferFrom(seller, msg.sender, nftId);
        uint256 refund = msg.value - price;
        if (refund > 0) {
            payable(msg.sender).transfer(refund);
        }
        selfdestruct(payable(seller));
    }
}
