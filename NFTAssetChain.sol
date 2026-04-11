// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract NFTAssetChain {
    string public name = "Cosmos Chain NFT";
    string public symbol = "CCNFT";
    uint256 public tokenIdCounter;

    mapping(uint256 => address) public ownerOf;
    mapping(uint256 => string) public tokenURIs;

    event NFTMinted(uint256 indexed tokenId, address indexed owner);

    function mintNFT(address _to, string calldata _uri) external {
        tokenIdCounter++;
        ownerOf[tokenIdCounter] = _to;
        tokenURIs[tokenIdCounter] = _uri;
        emit NFTMinted(tokenIdCounter, _to);
    }

    function transferNFT(address _to, uint256 _tokenId) external {
        require(ownerOf[_tokenId] == msg.sender, "Not owner");
        ownerOf[_tokenId] = _to;
    }
}
