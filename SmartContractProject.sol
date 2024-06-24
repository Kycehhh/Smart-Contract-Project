// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract ErrorHandling {
    uint public balance;
    
    constructor() {
        balance = 0;
    }

    // Function to deposit amount to balance
    function deposit(uint amount) public {
        require(amount > 0, "Amount must be greater than zero");
        balance += amount;
    }

    // Function to withdraw amount from balance
    function withdraw(uint amount) public {
        require(amount <= balance, "Insufficient balance");
        balance -= amount;
    }

    // Function to reset balance to zero
    function resetBalance() public {
        assert(balance >= 0);
        balance = 0;
    }

    // Function to force an error
    function forceError() public pure {
        revert("This is a forced error");
    }
}