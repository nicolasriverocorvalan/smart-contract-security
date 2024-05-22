// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract FoundForce {
    constructor(address payable _forceAddress) payable {
        selfdestruct(_forceAddress);
    }
}
