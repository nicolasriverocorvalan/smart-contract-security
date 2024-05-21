// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {CoinFlipAttack} from "../src/CoinFlipAttack.sol";

contract DeployCoinFlipAttack is Script {
    address private constant COINFLIP_ADDRESS = 0x0f46BC0Cf5245130C48Dde801bcDAA30875E5654; //CoinFlip contract to attack

    function run() external returns (CoinFlipAttack) {
        vm.startBroadcast();

        CoinFlipAttack coinFlipAttack = new CoinFlipAttack(COINFLIP_ADDRESS);

        vm.stopBroadcast();
        return coinFlipAttack;
    }
}
