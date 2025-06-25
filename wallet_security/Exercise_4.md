# Exercise 4

Now, can you sign a safe transaction where the signer is another safe? Let's find out...

We are attempting to send 0.01 WETH from our valiud multi-sig wallet 0x4087d2046A7435911fC26DCFac1c2Db26957Ab72 to 0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045 on the Arbitrum network. You are using safe version 1.4.1. Our main signer is another safe wallet at address 0x5031f5E2ed384978dca63306dc28A68a6Fc33e81 using safe version 1.4.1.

Please sign this transaction if doing so will bring you closer to executing, otherwise reject it.

```bash
call transfer on WETH1
dst (address)
arb:0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045

wad (uint256)
10000000000000000

Advanced details

to:
arb:0x82af49447d8a07e3bd95bd0d56f35241523fbab1

value:
10000000000000000

data:
0xa9059cbb00000000...6fc10000

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
arb:0x0000000000000000000000000000000000000000

nonce:
3
Transaction Hashes
Domain Hash:
0x886981c7ac254ace571077f0a055e84e72dac298c286f3b83638eaa308820d082

Message Hash:
0xa95cd534867e78aa5866b22e278984004eca36cff555462c50be402f7b292832

safeTxHash:
0x46fcaf713a45a85097ddb1b9e0fbcc247e822d2032c8f69e73685c7d8f507fa0
```

```bash
call approveHash on 0x4087d2046A7435911fC26DCFac1c2Db26957Ab72
hashToApprove (bytes32)
0x46fcaf713a45a85097ddb1b9e0fbcc247e822d2032c8f69e73685c7d8f507fa0

Advanced details

to:
arb:0x82af49447d8a07e3bd95bd0d56f35241523fbab1

value:
10000000000000000

data:
0xd4d9bdcd46fcaf71...8f507fa0

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
arb:0x0000000000000000000000000000000000000000

nonce:
5
Transaction Hashes
Domain Hash:
0x3269807350d9dc0089b20781ce2f4ca71614ada2a1a116d0c79a6d801e033f8d

Message Hash:
0x870f0b85c95ffc9657a8ba0b4fbdc43d4cca1ed8400290ab97b19b5befe51e49

safeTxHash:
0xde604d0d4e6cdb1cf39e8ff1b8c3ece230c2ec921b2538d6bbdb9cae54534c06
```

```bash
Signature Request
From: https://app.safe.global/
Message to sign:
{
    "types": {
        "SafeTx": [
            {
                "name": "to",
                "type": "address"
            },
            {
                "name": "value",
                "type": "uint256"
            },
            {
                "name": "data",
                "type": "bytes"
            },
            {
                "name": "operation",
                "type": "uint8"
            },
            {
                "name": "safeTxGas",
                "type": "uint256"
            },
            {
                "name": "baseGas",
                "type": "uint256"
            },
            {
                "name": "gasPrice",
                "type": "uint256"
            },
            {
                "name": "gasToken",
                "type": "address"
            },
            {
                "name": "refundReceiver",
                "type": "address"
            },
            {
                "name": "nonce",
                "type": "uint256"
            }
        ],
        "EIP712Domain": [
            {
                "name": "chainId",
                "type": "uint256"
            },
            {
                "name": "verifyingContract",
                "type": "address"
            }
        ]
    },
    "domain": {
        "chainId": "0xa4b1",
        "verifyingContract": "0x5031f5E2ed384978dca63306dc28A68a6Fc33e81"
    },
    "primaryType": "SafeTx",
    "message": {
        "to": "0x4087d2046A7435911fC26DCFac1c2Db26957Ab72",
        "value": "0",
        "data": "0xd4d9bdcd46fcaf713a45a85097ddb1b9e0fbcc247e822d2032c8f69e73685c7d8f507fa0", 
        "operation": "0",
        "safeTxGas": "0",
        "baseGas": "0",
        "gasPrice": "0",
        "gasToken": "0x0000000000000000000000000000000000000000",
        "refundReceiver": "0x0000000000000000000000000000000000000000",
        "nonce": "5"
    }
}
```

`Result-> approved`

You're signing a transaction from one Safe wallet that will be used to sign another Safe transaction. Whenever a Safe{Wallet} is a signer of another Safe{Wallet}, the signing wallet calls the `approveHash(bytes32)` function on the original Safe{Wallet}. Using safe-hash we could either try:

1. `--nested-safe-address`.
2. Manually calculate both hashes.
