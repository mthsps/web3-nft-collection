// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

import {Base64} from "./libraries/Base64.sol";

contract MyEpicNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string baseSvg =
        "<svg  xmlns='http://www.w3.org/2000/svg'  preserveAspectRatio='xMinYMin meet'  viewBox='0 0 350 350'>  <defs>    <linearGradient id='Gradient1'>      <stop class='stop1' offset='0%'/>      <stop class='stop2' offset='50%'/>      <stop class='stop3' offset='100%'/>    </linearGradient>  </defs>  <style>    .base {      fill: blue;      font-family: serif;      font-size: 20px;      color: #FFF;    }    .stop1 { stop-color: green; }    .stop2 { stop-color: white; stop-opacity: 0; }    .stop3 { stop-color: yellow; }      </style>  <rect width='100%' height='100%' fill='url(#Gradient1)' />  <text    x='50%'    y='50%'    class='base'    dominant-baseline='middle'    text-anchor='middle'  >";

    string[] jamesJoyceWords = [
        "Ripripple",
        "Poppysysmic",
        "Plopslop",
        "Pelurious",
        "Smilesmirk",
        "Smellsip",
        "Mumchanciness",
        "Qeggebobble",
        "Skeeze",
        "Peloothered",
        "Tattarrattat",
        "Impotentizing",
        "Pornosophical",
        "Yogibogeybox"
    ];
    string[] guimaraesRosaWords = [
        "Enxadachim",
        "Taurophtongo",
        "Embriagatinhar ",
        "Velvo",
        "Circuntristeza",
        "Desafogareu",
        "Mumchanciness",
        "Cigarrando",
        "Justinhamente",
        "Essezinho",
        "Ossoso",
        "Bisbrisa",
        "Desfalar",
        "Agarrante"
    ];
    string[] marioDeAndradeWords = [
        "Cantacantar",
        "Dandar",
        "Dondoca",
        "Fuomfuom",
        "Jusque",
        "Hhhm",
        "Tarata",
        "Voronofizar",
        "Zangueza",
        "Assimzinha",
        "Chiuiii",
        "Brekekex",
        "Brincabrincar"
    ];

    constructor() ERC721("Random3NeologismNFT", "3NEOLOGISMS") {
        console.log("A new NFT contract is born!");
    }

    function pickRandomFirstWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId)))
        );
        rand = rand % jamesJoyceWords.length;
        return jamesJoyceWords[rand];
    }

    function pickRandomSecondWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId)))
        );
        rand = rand % guimaraesRosaWords.length;
        return guimaraesRosaWords[rand];
    }

    function pickRandomThirdWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        uint256 rand = random(
            string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId)))
        );
        rand = rand % marioDeAndradeWords.length;
        return marioDeAndradeWords[rand];
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function makeAnEpicNFT() public {
        uint256 newItemId = _tokenIds.current();

        string memory first = pickRandomFirstWord(newItemId);
        string memory second = pickRandomSecondWord(newItemId);
        string memory third = pickRandomThirdWord(newItemId);

        string memory combinedWord = string(
            abi.encodePacked(first, second, third)
        );

        string memory finalSvg = string(
            abi.encodePacked(baseSvg, combinedWord, "</text></svg>")
        );

        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        combinedWord,
                        '", "description": "NFT collection of three random words taken from neologisms", "image": "data:image/svg+xml;base64,',
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );

        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        console.log("\n--------------------");
        console.log(finalTokenUri);
        console.log("--------------------\n");

        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, finalTokenUri);

        _tokenIds.increment();
        console.log(
            "A NFT with ID %s was minted for %s",
            newItemId,
            msg.sender
        );
    }
}
