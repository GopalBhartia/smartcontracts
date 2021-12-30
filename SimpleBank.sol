// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleBank {
    mapping(address => uint256) private balances;

    // amount deposited is the value sent during the contract deployement
    constructor() payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 withdrawAmount) external {
        require(withdrawAmount <= balances[msg.sender], "balance too low");
        balances[msg.sender] -= withdrawAmount;
        payable(msg.sender).transfer(withdrawAmount);
    }

    function checkBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}
