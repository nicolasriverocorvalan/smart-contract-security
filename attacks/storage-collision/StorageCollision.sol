// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Proxy} from "@openzeppelin/contracts/proxy/Proxy.sol";

contract StorageCollisionProxy is Proxy {

    // constant that defines the storage slot where the address of the current implementation contract is stored
    bytes32 private constant _IMPLEMENTATION_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

    function setImplementation(address newImplementation) public {
    // allows to set a new implementation contract. It uses inline assembly to directly interact with the EVM storage
        assembly {
            sstore(_IMPLEMENTATION_SLOT, newImplementation)
        }
    }

    function _implementation() internal view override returns (address implementationAddress) {
    // returns the current implementation contract. It also uses inline assembly to directly interact with the EVM storage
        assembly {
            implementationAddress := sload(_IMPLEMENTATION_SLOT)
        }
    }

    // helper function
    function getDataToTransact(uint256 numberToUpdate) public pure returns (bytes memory) {
    // returns the ABI-encoded function call to setValue(uint256)    
        return abi.encodeWithSignature("setValue(uint256)", numberToUpdate);
    }

    function readStorage(uint256 storageSlot) public view returns (uint256 vauleAtStorageSlot) {
    // read the value at a specific storage slot. It uses inline assembly to directly interact with the EVM storage    
        assembly {
            vauleAtStorageSlot := sload(storageSlot)
        }
    }

    receive() external payable {
    // fallback function that calls the _fallback() function from the Proxy contract    
        _fallback();
    }
}

contract ImplementationA {
    uint256 public value;

    function setValue(uint256 newValue) public {
        value = newValue;
    }
}

contract ImplementationB {
    /* 
        bool state variable initialized before the value state variable can cause a storage collision if ImplementationB 
        is used as the implementation for the proxy after ImplementationA, because the storage layout of the two contracts 
        is different.
    */
    bool public initialized;

    uint256 public value;

    function setValue(uint256 newValue) public {
        value = newValue + 2;
    }
}
