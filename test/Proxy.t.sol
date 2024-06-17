// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";
import {LogicContract} from "../src/LogicContrat.sol";
import {Proxy} from "../src/Proxy.sol";

contract CounterTest is Test {
    LogicContract public logic;
    Proxy public proxy;

    function setUp() public {
      logic = new LogicContract();
      proxy = new Proxy(address(logic));
    }

    function test_proxy_incremet() public {
      LogicContract(address(proxy)).setNum(1);
      assertEq(LogicContract(address(proxy)).getNum(), 1);
    }
}
