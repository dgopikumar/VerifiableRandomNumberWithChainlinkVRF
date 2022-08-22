//SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

contract RandomNumber is VRFConsumerBase {
    bytes32 internal keyHash;
    uint internal fee;
    uint public randomResult;

    constructor() VRFConsumerBase(
        0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D, //VRF coordinator goerli network
        0x326C977E6efc84E512bB9C30f76E30c160eD06FB //LINK token address
        ) {
            keyHash = 0x79d3d8832d904592c0bf9818b621522c988bb8b0c05cdc3b15aea1b6e8db0c15;
            fee = 0.25 * 10 ** 18;      
    }

    function getRandomNumber() public returns(bytes32 requestId) {
        require(LINK.balanceOf(address(this)) >= fee, "Not enough LINK in contract");
        return requestRandomness(keyHash, fee);
    }

    function fulfillRandomness(bytes32 requestId, uint randomness) internal override {
        randomResult = randomness;
    }

    function getFeeAmount() public view returns(uint) {
        return fee;
    }

    function getContractBalance() public view returns(uint) {
        return LINK.balanceOf(address(this));
    }
}