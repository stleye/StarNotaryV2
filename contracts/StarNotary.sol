// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.24;

import "../app/node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract StarNotary is ERC721 {

    struct Star {
        string name;
    }

    mapping(uint256 => Star) public tokenIdToStarInfo;
    mapping(uint256 => uint256) public starsForSale;

    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) { }

    // Create Star using the Struct
    function createStar(string memory _name, uint256 _tokenId) public { // Passing the name and tokenId as a parameters
        Star memory newStar = Star(_name); // Star is an struct so we are creating a new Star
        tokenIdToStarInfo[_tokenId] = newStar; // Creating in memory the Star -> tokenId mapping
        _mint(msg.sender, _tokenId); // _mint assign the star with _tokenId to the sender address (ownership)
    }

    // Putting an Star for sale (Adding the star tokenid into the mapping starsForSale, first verify that the sender is the owner)
    function putStarUpForSale(uint256 _tokenId, uint256 _price) public {
        require(ownerOf(_tokenId) == msg.sender, "You can't sale the Star you don't owned");
        starsForSale[_tokenId] = _price;
    }

    // Function that allows you to convert an address into a payable address
    function _make_payable(address x) internal pure returns (address payable) {
        return payable(address(uint160(x)));
    }

    function buyStar(uint256 _tokenId) public payable {
        require(starsForSale[_tokenId] > 0, "The Star should be up for sale");
        uint256 starCost = starsForSale[_tokenId];
        address starOwner = ownerOf(_tokenId);
        require(msg.value > starCost, "You need to have enough Ether");
        _transfer(starOwner, msg.sender, _tokenId);
        address payable starOwnerPayable = _make_payable(starOwner); // We need to make this conversion to be able to use transfer() function to transfer ethers
        starOwnerPayable.transfer(starCost);
        if(msg.value > starCost) { //If there is an extra value that was sent, we return it to the sender
            address payable senderAddressPayable = _make_payable(msg.sender);
            senderAddressPayable.transfer(msg.value - starCost);
        }
        starsForSale[_tokenId] = 0;

    }

}