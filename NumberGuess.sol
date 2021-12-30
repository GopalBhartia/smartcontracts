// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract NumberGuess {
    uint256 private answer;
    address public winner;
    address public owner;
    uint256 public jackpot = address(this).balance;
    uint256 count = 0;
    bool isGameOn = true;

    //Upon initiation of the contract, owner of the contract has to put in 300 wei as jackpot
    constructor(uint256 number) payable {
        require(0 < number && number <= 10, "Number provided should be 1-10");
        require(
            msg.value == 300 wei,
            "300 wei initial funding required for reward"
        );
        answer = number;
        owner = msg.sender;
    }

    //Player can participate by paying 10 wei and take a guess
    function guess(uint256 number) public payable {
        jackpot = address(this).balance;
        require(0 < number && number <= 10, "Number provided should be 1-10");
        require(isGameOn == true, "The game is over!");
        require(msg.value == 10 wei, "You have to pay 10 wei to play the game");
        require(
            msg.sender != owner,
            "you are the owner. You are not allowed to play!"
        );
        count += 1;
        if (number == answer) {
            winner = msg.sender;
            payable(winner).transfer(jackpot);
            isGameOn = false;
        }
        if (count == 5) {
            payable(owner).transfer(jackpot);
            isGameOn = false;
        }
    }
}
