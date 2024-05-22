# Force

Make the balance of the contract greater than zero.

## Notes

```
`selfdestruct` has been deprecated. Note that, starting from the `Cancun` hard fork, the opcode no longer deletes the code and data associated with an account and only transfers its Ether to the beneficiary, unless executed in the same transaction in which the contract was created (see EIP-6780). Any use in newly deployed contracts is strongly discouraged even if the new behavior is taken into account. Future changes to the EVM might further reduce the functionality of the opcode.
````

In Ethereum, you can send Ether to a contract in two ways:

1. By calling a payable function in the contract.
2. By sending Ether to the contract's address.

The `Force` contract doesn't have any functions. So, the only way to increase its balance is by sending Ether directly to the contract's address.

## Found

