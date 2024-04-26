// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import { Script, console2 } from "forge-std/Script.sol";
import { Counter } from "src/Counter.sol";

contract Deployer is Script {
    function run() public {
        vm.startBroadcast();
        deploy();
        vm.stopBroadcast();
    }

    function deploy() public returns (Counter) {
        Counter counter = new Counter();
        return counter;
    }
}
