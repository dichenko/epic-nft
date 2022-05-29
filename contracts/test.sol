// SPDX-License-Identifier: GPL-3.0
import "@openzeppelin/contracts/utils/Strings.sol";
pragma solidity >=0.7.0 <0.9.0;

contract Bullet{
    string[] words = [ "fucking", "got", "don't", "out", "going", "man", "fuck", "and", "get", "come", "here", "right", "know", "want", "shit", "him",  "for", "see", "about", "motherfucker", "ain't", "take", "have", "just", "doing", "bullet", "like",  "now", "lester", "how", "give", "look", "think",  "why", "back", "yeah", "tell", "let", "something",  "ass",  "that's", "down", "good", "some", "little",  "over", "tank", "around", "could","when", "baby", "car", "talking", "time", "shut", "make", "brother", "thought", "louis", "love", "will", "ruby", "stop", "old", "find", "paddy", "hit", "boy", "ever", "did", "too", "because", "should", "understand", "talk","black", "care", "there's", "listen", "money", "butch", "say", "thing", "people", "problem", "it's", "really", "tonight", "two", "dick", "stay", "who", "way", "please", "jesus", "better", "bitch"];


    function firstWord(uint _nonce) public view returns(string memory){
        bytes32 h = keccak256(
            abi.encodePacked(
                Strings.toString(_nonce), 
                Strings.toString(uint160(msg.sender))
            )
        );
        return words[uint(h)%100%words.length];
        
    }

    function secondWord(uint _nonce) public view returns(string memory){
        bytes32 h = keccak256(
            abi.encodePacked(
                Strings.toString(_nonce), 
                Strings.toString(uint160(msg.sender))
            )
        );
        return words[uint(h)/100%100%words.length];
    }

     function thirdWord(uint _nonce) public view returns(string memory){
        bytes32 h = keccak256(
            abi.encodePacked(
                Strings.toString(_nonce), 
                Strings.toString(uint160(msg.sender))
            )
        );
        return words[uint(h)/10000%100%words.length];
    }

}