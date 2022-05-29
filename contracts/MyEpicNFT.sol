// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1;
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import {Base64} from "./libraries/Base64.sol";

contract BulletNFT is ERC721URIStorage {
    
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    string w1;
    string w2;
    string w3;
    string svg1 =
        '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.base{fill:#370617;font-family:serif;font-size:14px}</style><rect width="100%" height="100%" fill="#161b33"/><path fill="';
    string svg2 =
        '" d="m134.35-148.492 197.99 197.99-197.99 197.99-197.99-197.99z"/><path fill="';
    string svg3 =
        '" d="m70.71 141.421 212.133 212.132L70.71 565.685l-212.132-212.132z"/><text x="36%" y="20%" dominant-baseline="middle" text-anchor="middle" font-family="monserrat" fill="#FBB539" font-size="1.2em">';
    string svg4 = '</text><text x="60%" y="40%" dominant-baseline="middle" text-anchor="middle" font-family="lato" fill="#FBB539" font-size="2.5em">';
    string svg5 ='</text><text x="30%" y="80%" dominant-baseline="middle" text-anchor="middle" fill="#FBB539" font-size="1.5em">';
    string svg6 ='</text></svg>';
    string[] colors = ["#6A040F","#9D0208","#D00000","#DC2F02","#E85D04"];

    string color1;
    string color2;
    

    string[] words = [
        "fucking",
        "got",
        "don't",
        "out",
        "going",
        "man",
        "fuck",
        "and",
        "get",
        "come",
        "here",
        "right",
        "know",
        "want",
        "shit",
        "him",
        "for",
        "see",
        "about",
        "motherfucker",
        "ain't",
        "take",
        "have",
        "just",
        "doing",
        "bullet",
        "like",
        "now",
        "lester",
        "how",
        "give",
        "look",
        "think",
        "why",
        "back",
        "yeah",
        "tell",
        "let",
        "something",
        "ass",
        "that's",
        "down",
        "good",
        "some",
        "little",
        "over",
        "tank",
        "around",
        "could",
        "when",
        "baby",
        "car",
        "talking",
        "time",
        "shut",
        "make",
        "brother",
        "thought",
        "louis",
        "love",
        "will",
        "ruby",
        "stop",
        "old",
        "find",
        "paddy",
        "hit",
        "boy",
        "ever",
        "did",
        "too",
        "because",
        "should",
        "understand",
        "talk",
        "black",
        "care",
        "there's",
        "listen",
        "money",
        "butch",
        "say",
        "thing",
        "people",
        "problem",
        "it's",
        "really",
        "tonight",
        "two",
        "dick",
        "stay",
        "who",
        "way",
        "please",
        "jesus",
        "better",
        "bitch"
    ];

    event NewBullet(address indexed sender, uint256 indexed tokenId);

    function getHash(uint _nonce) public view returns (bytes32){
      return keccak256(
            abi.encodePacked(
                Strings.toString(_nonce),
                Strings.toString(uint160(msg.sender))
            )
        );
    }

    function firstWord(bytes32 _h) public view returns (string memory) {
        return words[(uint256(_h) % 100) % words.length];
    }

    function secondWord(bytes32 _h) public view returns (string memory) {
        return words[((uint256(_h) / 100) % 100) % words.length];
    }

    function thirdWord(bytes32 _h) public view returns (string memory) {
        return words[((uint256(_h) / 10000) % 100) % words.length];
    }

    function firstColor(bytes32 _h) public view returns (string memory) {
        return colors[((uint256(_h) / 100000) % 10) % colors.length];
    }

    function secondColor(bytes32 _h) public view returns (string memory) {
        return colors[((uint256(_h) / 1000000) % 10) % colors.length];
    }

    constructor() ERC721("Bullet1996","BLLT") {}

    function makeBulletNFT() public {
        uint256 newItemId = _tokenIds.current();
        bytes32 _h = getHash(newItemId);
        w1 = firstWord(_h);
        w2 = secondWord(_h);
        w3 = thirdWord(_h);
        color1 = firstColor(_h);
        color2 = secondColor(_h);
        string memory combinedWord = string(abi.encodePacked(w1, w2, w3));
        string memory finalSvg = string(
            abi.encodePacked(svg1, color1, svg2, color2, svg3, w1, svg4, w2, svg5, w3, svg6)
        );
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        combinedWord,
                        '", "description": "3 of 100 most frequent words from Bullet movie ", "image": "data:image/svg+xml;base64,',
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );

        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, finalTokenUri);
        emit NewBullet(msg.sender, newItemId);
        _tokenIds.increment();
    }
}
