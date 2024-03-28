// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

interface IERC20 {
    // Returns the total token supply
    function totalSupply() external view returns (uint256);

    // Returns the account balance of another account with address _owner
    function balanceOf(address _owner) external view returns (uint256);

    // Transfers _value amount of tokens to address _to
    function transfer(address _to, uint256 _value) external returns (bool);

    // Transfers _value amount of tokens from address _from to address _to
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) external returns (bool);

    // Allows _spender to withdraw from your account multiple times, up to the _value amount
    function approve(address _spender, uint256 _value) external returns (bool);

    // Returns the amount which _spender is still allowed to withdraw from _owner
    function allowance(
        address _owner,
        address _spender
    ) external view returns (uint256);

    // Event triggered when tokens are transferred
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    // Event triggered when approval is granted for allowance
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );
}
