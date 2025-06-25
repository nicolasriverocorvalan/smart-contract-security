# Exercise 1

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
```

```bash
Function:depositETH(address,address,uint16)
Param #1
0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
Param #2
0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
Param #3
0
Data:
0x474cf53d000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb92266000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb922660000000000000000000000000000000000000000000000000000000000000000
```

## Solution

* The official address for the Aave V3 WETHGateway on ZKsync Era is indeed 0xAE2b00D676130Bdf22582781BbBA8f4F21e8B0ff. So, the destination address is correct.
* https://era.zksync.network/address/0xAE2b00D676130Bdf22582781BbBA8f4F21e8B0ff#code

```bash
cast 4byte-calldata 0x474cf53d000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb92266000000000000000000000000f39fd6e51aad88f6f4ce6ab8827279cfffb922660000000000000000000000000000000000000000000000000000000000000000

1) "depositETH(address,address,uint16)"
0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 # A blank address, that could be anything
0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 # (onBehalfOf address, OK)
0 # The referral code, which is a number that Aave uses to track referrals. This is not important for us
```

`Result-> approved`
