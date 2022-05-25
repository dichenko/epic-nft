// SPDX-License-Identifier: GPL-3.0
import "@openzeppelin/contracts/utils/Strings.sol";
pragma solidity >=0.7.0 <0.9.0;

contract Epic{
    string[] words = ["you", "the", "that", "what", "your", "going", "don't", "got", "this", "man", "here", "out", "are", "get", "with", "and", "l'm", "ing", "come", "all", "just", "you're", "right", "take", "for", "about", "want", "have", "not", "doing", "lt's", "yeah", "give", "back", "him", "look", "like", "car", "how", "motherf", "ain't", "ass", "know", "see", "some", "he's", "what's", "bullet", "think", "something", "off", "them", "listen", "tell", "good", "now", "from", "lester", "why", "around", "over", "his", "will", "let's", "stay", "can", "can't", "was", "job", "okay", "care", "talking", "ruby", "two", "make", "thing", "yourself", "please", "tank", "down", "where", "too", "l'll", "there", "really", "move", "convict", "they're", "flaco", "chill", "money", "ever", "problem", "kind", "little", "never", "could", "matter", "find", "tonight", "cash", "paddy", "that's", "war", "baby", "there's", "piece", "shut", "stop", "such", "dick", "business", "looking", "butch", "hell", "people", "spic", "mind", "jesus", "christ", "nothing", "because"];


    function firstWord(uint _nonce) public view returns(bytes32){
        bytes32 h = keccak256(
            abi.encodePacked(
                Strings.toString(_nonce), 
                Strings.toString(uint160(msg.sender))
            )
        );
        return h;
        //return uint8((number % 1000) % words.length);
    }



}