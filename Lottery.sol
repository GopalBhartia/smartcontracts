// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Lottery {
    enum State {
        IDLE,
        BETTING
    }
    State public currentState = State.IDLE;
    address payable[] public betters;
    uint256 public betSize;
    uint256 public betCount;
    uint256 public fees = 5;
    address public admin;

    constructor() {
        admin = msg.sender;
    }

    function startBet(uint256 _betCount, uint256 _betSize)
        external
        onlyAdmin
        inState(State.IDLE)
    {
        betCount = _betCount;
        betSize = _betSize;
        currentState = State.BETTING;
    }

    function placeBet() external payable inState(State.BETTING) {
        require(
            msg.value == betSize,
            "Please bet exact amount according to bet size"
        );
        betters.push(payable(msg.sender));
        if (betters.length == betCount) {
            uint256 winner = pickWinner(betCount);
            betters[winner].transfer(
                ((100 - fees) * (betCount * betSize)) / 100
            );
            currentState = State.IDLE;
            delete betters;
        }
    }

    function cancelBet() external onlyAdmin inState(State.BETTING) {
        for (uint256 i = 0; i < betters.length; i++) {
            betters[i].transfer(betSize);
        }
        delete betters;
        currentState = State.IDLE;
    }

    function changeFees(uint256 _fees) external onlyAdmin inState(State.IDLE) {
        fees = _fees;
    }

    function pickWinner(uint256 _betCount) internal view returns (uint256) {
        return (uint256(
            keccak256(abi.encodePacked(block.timestamp, block.difficulty))
        ) % _betCount);
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "only admin allowed");
        _;
    }
    modifier inState(State state) {
        require(
            currentState == state,
            "Cannot perform this action in current state"
        );
        _;
    }
}
