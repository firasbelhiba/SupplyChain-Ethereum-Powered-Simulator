pragma solidity ^0.6.0;

import "./ItemManager.sol";

contract Item {
    uint256 public priceInWei;
    uint256 public pricePaid;
    uint256 public index;
    ItemManager parentContract;

    constructor(
        ItemManager _parentContract,
        uint256 _priceInWei,
        uint256 _index
    ) public {
        parentContract = _parentContract;
        priceInWei = _priceInWei;
        index = _index;
    }

    // Fallback function in solidity ^0.6.0
    receive() external payable {
        require(pricePaid == 0, "Item is already paid");
        require(priceInWei == msg.value, "Only full payments are allowed");
        pricePaid += msg.value;
        (bool success, ) = address(parentContract).call.value(msg.value)(
            abi.encodeWithSignature("triggerPayment(uint256)", index)
        );
        require(success, "the transaction wasn't successful");
    }

    fallback() external {}
}
