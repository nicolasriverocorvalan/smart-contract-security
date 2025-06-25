# Examples

## Exercise 1
You've grown weary of sending so many transactions, and you are excited to hear that Aave now supports EIP-7702! You are attempting to both approve 100 USDC token on the Ethereum network AND supply 100 USDC on behalf of yourself to Aave.

```bash
Confirm transaction
Ethereum
Type: Smart Account
0x63c0c19a282a1B52b07dD5a65b58948A07DAE32B
Function:execute((address,uint256,bytes))

From (your account)
0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
To
0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
Amount
0 ETH
Estimated fee
$0.12
0.00124ETH


Transaction 1
Interacting with 0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48 (usdc contract)
Calldata: 0x095ea7b300000000000000000000000087870bca3f3fd6335c3f4ce8392d69350b4fa4e20000000000000000000000000000000000000000000000000000000005f5e100

{
  "function": "approve(address,uint256)",
  "params": [
    "0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2", (Aave Pool contract)
    "100000000"
  ]
}

Transaction 2
Interacting with 0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2 (Aave Pool contract)
Calldata: 0x617ba037000000000000000000000000a0b86991c6218b36c1d19d4a2e9eb0ce3606eb480000000000000000000000000000000000000000000000000000000005f5e100000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb922660000000000000000000000000000000000000000000000000000000000000000

{
  "function": "supply(address,uint256,address,uint16)",
  "params": [
    "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48", (usdc contract)
    "100000000",
    "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266", (your account)
    "0"
  ]
}
```

`Approved`: The two-step process performed in the transaction is the standard for all DeFi applications:

1. `approve()` on the TOKEN contract
   * Call the `approve` function on the USDC contract (0xA0b8...eB48).
   * You tell it: "I approve the Aave Pool (0x8787...4E2) to spend 100000000 of my tokens."
   * Result: The USDC contract now has a record that says, "The Aave Pool is allowed to take up to 100 USDC from this user's balance".

2. Step 2: supply() on the `AAVE POOL contract`
   * Call the `supply` function on the Aave Pool contract (0x8787...4E2).
   * You tell it: "I would like to supply 100 USDC."
   * Result: The Aave Pool contract, when executing your supply request, then turns to the USDC contract and says, "I need to transfer 100 USDC from this user's wallet to myself. Do I have permission?" Because of Step 1, the USDC contract says "Yes, you do," and allows the transfer to happen.
