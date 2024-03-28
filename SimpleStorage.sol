// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {
    // This variable will store the integer value
    uint256 public storedData;

    // Function to set the storedData variable
    function set(uint256 x) public {
        storedData = x;
    }

    // Function to get the storedData variable
    function get() public view returns (uint256) {
        return storedData;
    }
}
