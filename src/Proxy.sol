
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Proxy {
    // Storage slot for the address of the current implementation
    address public implementation;

    constructor(address _implementation) {
        implementation = _implementation;
    }

    // Function to update the implementation address
    function upgrade(address _newImplementation) external {
        implementation = _newImplementation;
    }

    // Fallback function for delegating calls to the implementation
    fallback() external payable {
        address _impl = implementation;
        require(_impl != address(0), "Implementation not set");

        assembly {
            // Copy the data sent to the memory position 0x80
            calldatacopy(0x0, 0x0, calldatasize())

            // Forward the call to the implementation contract
            let result := delegatecall(gas(), _impl, 0x0, calldatasize(), 0x0, 0)

            // Retrieve the size of the returned data
            let size := returndatasize()

            // Copy the returned data to memory position 0x80
            returndatacopy(0x0, 0x0, size)

            // Depending on the result, return or revert
            if result {
                return(0x0, size)
            }
            revert(0x0, size)
        }
    }
}
