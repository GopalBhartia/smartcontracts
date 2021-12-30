// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

contract Calculator {
    function add(int256 _a, int256 _b) external pure returns (int256) {
        return _a + _b;
    }

    function minus(int256 _a, int256 _b) external pure returns (int256) {
        return _a - _b;
    }

    function multiply(int256 _a, int256 _b) external pure returns (int256) {
        return _a * _b;
    }

    function divide(int256 _a, int256 _b)
        external
        pure
        notZero(_b)
        returns (int256)
    {
        return _a / _b;
    }

    modifier notZero(int256 a) {
        require(a != 0, "Error!! Cannot divide by 0");
        _;
    }
}
