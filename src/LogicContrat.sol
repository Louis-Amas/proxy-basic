
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LogicContract {
    address public implementation;
    uint256 public num;

    function setNum(uint256 _num) public {
        num = _num;
    }

    function getNum() public view returns (uint256) {
        return num;
    }
}
