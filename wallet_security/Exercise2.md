# Exercise 2

Here we go again! But this time, your wallet is having a hard time decoding the data. Instead of showing you the parameters like we did in the last question, it just shows you the "raw" data. A wallet can have a hard time turning this "raw" data into the easier to read parameters if the transaction data is too complicated or your wallet doesn't recognize the type of transaction.

Assume your wallet address is 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266. You want to deposit 1 ETH into Aave to begin gaining interest on the ZKsync Era network. Yes, use the real Aave contract address on ZKsync Era if that helps.

Will signing this accomplish that? If so, please sign, otherwise reject.

```bash
Confirm transaction
ZKsync Era
From (your account)
0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
To
0xAE2b00D676130Bdf22582781BbBA8f4F21e8B0ff
Amount
1 ETH
Estimated fee
$0.02
0.00004ETH
```

```bash
Function:depositETH(address,address,uint16)
Data:
0x474cf53d000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb9226600000000000000000000000023618e81e3f5cdf7f54c3d65f7fbc0abf5b21e8f0000000000000000000000000000000000000000000000000000000000000000
```

## Solution

```bash
cast 4byte-calldata 0x474cf53d000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb9226600000000000000000000000023618e81e3f5cdf7f54c3d65f7fbc0abf5b21e8f0000000000000000000000000000000000000000000000000000000000000000

1) "depositETH(address,address,uint16)"
0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f (wrong)
0
```
* The 2nd parameter is 0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f, which is not the wallet address we want. We want our own address here, since we want to deposit on behalf of our self.

`Result-> reject`
