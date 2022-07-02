// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract MyEpicNFT is ERC721URIStorage {
      using Counters for Counters.Counter;
      Counters.Counter private _tokenIds;
   constructor() ERC721 ("SquareNFT", "SQUARE") {
      console.log("A new NFT contract is born!");
   }

   function makeAnEpicNFT() public {
    uint256 newItemId = _tokenIds.current();
    _safeMint(msg.sender, newItemId);
    _setTokenURI(newItemId, "https://jsonkeeper.com/b/VK8X");
    console.log("A NFT with ID %s was minted for %s", newItemId, msg.sender);
    _tokenIds.increment();
   }


}