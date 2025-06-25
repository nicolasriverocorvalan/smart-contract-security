# Exercise 3

You've grown weary of sending so many transactions, and you are excited to hear that Aave now supports EIP-7702! You are attempting to both approve 100 USDC token on the Ethereum network AND supply 100 USDC on behalf of yourself to Aave.

If the transaction that populates does that, please sign it, otherwise reject

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
```

```bash
Transaction 1
Interacting with 0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48 (usdc contract)
Calldata: 0x095ea7b300000000000000000000000087870bca3f3fd6335c3f4ce8392d69350b4fa4e20000000000000000000000000000000000000000000000000000000005f5e100

{
    "function": "approve(address,uint256)",
    "params": [
        "0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2", (Aave Pool V3 contract)
    "100000000"
    ]
}

Transaction 2
Interacting with 0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2 (Aave Pool V3 contract)
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

## Solution

### Aave `supply` Function Breakdown

Here is a parameter-by-parameter breakdown of the `supply` call in your transaction.

```
supply(address asset, uint256 amount, address onBehalfOf, uint16 referralCode)
```
---
### **Param #1 (`address asset`): `0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48`**

* **Purpose:** This tells the Aave Pool **what** token you are supplying.
* **In your transaction:** This is correctly set to the official USDC token contract address on the Ethereum network.

### **Param #2 (`uint256 amount`): `100000000`**

* **Purpose:** This specifies **how much** of the asset you want to supply. It's crucial to note that this amount must account for the token's decimals.
* **In your transaction:** USDC has 6 decimals. Therefore, `100,000,000` represents exactly **100 USDC** (100 * 10^6). This is correct.

### **Param #3 (`address onBehalfOf`): `0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266`**

* **Purpose:** This defines **who** should be credited with the deposit. The interest-bearing tokens (aTokens, in this case `aEthUSDC`) will be minted to this address.
* **In your transaction:** This is correctly set to your own account address, ensuring you receive the credit for the deposit.

### **Param #4 (`uint16 referralCode`): `0`**

* **Purpose:** This is an optional code used by integrations and partners to track referrals.
* **In your transaction:** A value of `0` indicates no referral, which is the standard for a direct user interaction. This is correct.

1. `approve()` on the TOKEN contract
   * Call the `approve` function on the USDC contract (0xA0b8...eB48).
   * You tell it: "I approve the Aave Pool (0x8787...4E2) to spend 100000000 of my tokens."
   * Result: The USDC contract now has a record that says,
"The Aave Pool is allowed to take up to 100 USDC from this user's balance".

2. Step 2: supply() on the `AAVE POOL contract`
   * Call the `supply` function on the Aave Pool contract (0x8787...4E2).
   * You tell it: "I would like to supply 100 USDC."
   * Result: The Aave Pool contract, when executing your supply request, then turns to the USDC contract and says,
"I need to transfer 100 USDC from this user's wallet to myself. Do I have permission?" Because of Step 1, the USDC contract says "Yes, you do," and allows the transfer to happen.

`Result-> approved`: The two-step process performed in the transaction is the standard for all DeFi applications:
