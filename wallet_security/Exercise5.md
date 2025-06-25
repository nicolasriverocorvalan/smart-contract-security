# Exercise 5

Verifying the massive JSON data on your hardware wallet can be a nightmare, as you'll have to scroll through many many screens to see all the data, which can lead to security fatigue. So you should get good at verifying using only the domain and message hash (or, the EIP-712 hash).

Assume your wallet address is 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, and you are a signer on a valid mutlisig wallet at address 0x4087d2046A7435911fC26DCFac1c2Db26957Ab72 using safe version 1.4.1. You are attempting to deposit 0.1 ETH to the ZKsync Aave token pool. Please sign this transaction if doing so will bring you closer to executing, otherwise reject it.

Also assume, you have the settings of your hardware wallet set to show ONLY the Domain and Message hash, and not the entire JSON data. So when you see the Message page, you know that this is showing you the message hash and domain hash (domain separator) and not the actual JSON message.

```bash
Aave
Nonce #
1
call depositETHonWrappedTokenGatewayV3
Value:
0.1 ETH

(address)
zks:0xAE2b00D676130Bdf22582781BbBA8f4F21e8B0ff (WrappedTokenGatewayV3 ZKsync contract)

onBehalfOf (address)
zks:0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266 (your wallet)

referralCode (uint16)
0
```

```bash
Advanced details

to:
zks:0xAE2b00D676130Bdf22582781BbBA8f4F21e8B0ff

value:
100000000000000000

data:
0x474cf53d00000000...00000000

operation:
0
safeTxGas:
0
baseGas:
0
gasPrice:
0
gasPrice:
0
gasToken:
0x0000000000000000000000000000000000000000

refundReceiver:
zks:0x0000000000000000000000000000000000000000

nonce:
1
Transaction Hashes
Domain Hash:
0xe0392d263ff13e09757bfce9b182ead6ceabd9d1b404aa7df77e65b304969130

Message Hash:
0x02def9296d874a88cd65d1adfdb9c220a186f812113ae9a6080836932e3df670

safeTxHash:
0x87414b6a2a5c6664ddbc9b79392a2fd4ac5a294a6b807b70b28641b3b8af297b
```

## Solution

```bash
cast 4byte-calldata  0x474cf53d0000000000000000000000004087d2046a7435911fc26dcfac1c2db26957ab720000000000000000000000004087d2046a7435911fc26dcfac1c2db26957ab720000000000000000000000000000000000000000000000000000000000000000

1) "depositETH(address,address,uint16)"
0x4087d2046A7435911fC26DCFac1c2Db26957Ab72
0x4087d2046A7435911fC26DCFac1c2Db26957Ab72
0

✗ safe-hash typed --file Exercise5.json --standalone
EIP 712 Hash:            0x452952ca0a93e9a05d3c138dff85dffc061f196a7b428945aadc70f92687a75d
Domain Hash:             0xe0392d263ff13e09757bfce9b182ead6ceabd9d1b404aa7df77e65b304969130
Message Hash:            0xfac0c15391856b749f37c979c6068dac6e6264b182501425aaff9dac190a2daa
```

It turned out, in this case, the Safe UI was compromised, and it showed us an evil hash, and sent our wallet the evil hash. They had turned the operation from a 0 to a 1, which changed our transaction from a `call` to a `delegateCall`.

If you update your file.json to have the operation as a 1, or update the SafeUtils to use a `DELEGATECALL` instead of a `CALL` and rerun, you will get the same hash as our Trezor wallet - the malicious one!

`Result -> rejected`
