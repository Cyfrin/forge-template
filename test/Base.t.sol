// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import { Test, console } from "forge-std/Test.sol";
import { Counter } from "src/Counter.sol";
import { Deployer } from "script/Deployer.s.sol";

contract CounterTest is Test {
    Counter public counter;
    Deployer public deployer;

    function setUp() public {
        deployer = new Deployer();
        counter = deployer.deploy();
        counter.setNumber(0);
    }

    function test_Increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }
}
