const ItemManager = artifacts.require("./ItemManager.sol");

contract("ItemManager", (accounts) => {
  it("should be able to add an item", async function () {
    const itemManagerInstance = await itemManager.deployed();
    const itemName = "test1";
    const itemPrice = 1000;
    let result = await itemManagerInstance.createItem(itemName, itemPrice, {
      from: accounts[0],
    });
    console.log(result);
  });
});
