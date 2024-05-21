// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {TelephoneAttack} from "../src/TelephoneAttack.sol";
import {Telephone} from "../src/Telephone.sol";

contract DeployCoinFlipAttack is Script {
    Telephone public telephone;

    function run() external returns (TelephoneAttack) {
        vm.startBroadcast();

        TelephoneAttack telephoneAttack = new TelephoneAttack(telephone);

        vm.stopBroadcast();
        return telephoneAttack;
    }
}
