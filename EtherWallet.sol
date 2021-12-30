//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherWallet {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function deposit() public payable {}

    function send(address payable to, uint256 amount) public {
        if (msg.sender == owner) {
            to.transfer(amount);
            return;
        }
        revert("sender is not allowed");
    }

    function balanceOf() public view returns (uint256) {
        return address(this).balance;
    }
}
