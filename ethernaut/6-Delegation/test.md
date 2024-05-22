# Delegation

Claim ownership of the contract.

## Vulnerability

The `Delegate` contract has a function `pwn()` that allows anyone to change the owner of the contract. This is a critical vulnerability as it allows anyone to take over the contract.

The `Delegation` contract has a `fallback` function that uses `delegatecall` to the `Delegate` contract. The `delegatecall` function is dangerous because it executes code in the context of the calling contract, not the called contract. This means that if the `Delegate` contract's `pwn` function is called through the `Delegation` contract's `fallback` function, it will change the owner of the `Delegation` contract, not the `Delegate` contract.

## Attack

1. The attacker calls the `Delegation` contract with the data of the `pwn` function. This triggers the `fallback` function, which in turn calls the `pwn` function in the `Delegate` contract using `delegatecall`.

2. The `pwn` function in the `Delegate` contract changes the owner to `msg.sender`. However, because it's called with `delegatecall`, it executes in the context of the `Delegation` contract and changes the owner of the `Delegation` contract to the attacker.

## Fix

1. Remove the pwn function from the Delegate contract, or add access controls to ensure that only authorized users can change the owner.

2. Be very careful when using `delegatecall`, as it can lead to unexpected behavior. Consider using `call` instead, which executes code in the context of the called contract. If you must use `delegatecall`, make sure to thoroughly review the called contract to ensure it can't change critical state variables in the calling contract.
