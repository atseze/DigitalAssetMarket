// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract DigitalAssetMarket {
    enum AssetState {
        OpenToSale,
        OutOfSale
    }
    struct DigitallAsset {
        string name;
        address owner;
        AssetState state;
        uint price;
    }
    DigitallAsset[] public assets;
    event NewSale(
        address seller,
        address buyer,
        uint assetId,
        uint price,
        uint time
    );

    function addAsset(string memory _name, uint _price) public returns (uint) {
        require(bytes(_name).length > 0, "Name for asset is required");
        require(_price > 0, "Price must be greater than zero!");

        DigitallAsset memory newAsset;
        newAsset.name = _name;
        newAsset.owner = msg.sender;
        newAsset.state = AssetState.OpenToSale;
        newAsset.price = _price;
        assets.push(newAsset);
        return (assets.length - 1);
    }

    function buy(uint _assetIndex) public payable {
        require(
            assets.length > _assetIndex,
            "The asset reference is not valid!"
        );
        DigitallAsset memory theAsset = assets[_assetIndex];
        require(theAsset.owner != msg.sender, "This item is yours!");
        require(
            theAsset.state == AssetState.OpenToSale,
            "This item is not for sale!"
        );
        require(theAsset.price == msg.value, "Value and price are different!");

        theAsset.state = AssetState.OutOfSale;
        payable(theAsset.owner).transfer(msg.value);
        address oldOwner = theAsset.owner;
        theAsset.owner = msg.sender;
        assets[_assetIndex] = theAsset;
        emit NewSale(
            oldOwner,
            msg.sender,
            _assetIndex,
            theAsset.price,
            block.timestamp
        );
    }
}