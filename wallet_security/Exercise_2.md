# Exercise 2

Assume your wallet address is 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, and you are a signer on a valid mutlisig wallet at address 0x4087d2046A7435911fC26DCFac1c2Db26957Ab72 using safe version 1.4.1. You are attempting to send 1 WETH to address: 0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045 on the Arbitrum network. Please sign or reject this transaction, if doing so will bring you closer to executing.

```bash
Signature Request
From: https: //app.safe.global/

Message to sign: {
    "types": {
        "SafeTx": [
            {
                "type": "address",
                "name": "to"
            },
            {
                "type": "uint256",
                "name": "value"
            },
            {
                "type": "bytes",
                "name": "data"
            },
            {
                "type": "uint8",
                "name": "operation"
            },
            {
                "type": "uint256",
                "name": "safeTxGas"
            },
            {
                "type": "uint256",
                "name": "baseGas"
            },
            {
                "type": "uint256",
                "name": "gasPrice"
            },
            {
                "type": "address",
                "name": "gasToken"
            },
            {
                "type": "address",
                "name": "refundReceiver"
            },
            {
                "type": "uint256",
                "name": "nonce"
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
        "chainId": "42161",
        "verifyingContract": "0x4087d2046A7435911fC26DCFac1c2Db26957Ab72"
    },
    "primaryType": "SafeTx",
    "message": {
        "to": "0x82af49447d8a07e3bd95bd0d56f35241523fbab1", (Wrapped Ether (WETH) contract on Arbitrum)
        "value": "0",
        "data": "0xa9059cbb000000000000000000000000d8da6bf26964af9d7eed9e03e53415d37aa960450000000000000000000000000000000000000000000000000de0b6b3a7640000",
        "operation": "0",
        "safeTxGas": "0",
        "baseGas": "0",
        "gasPrice": "0",
        "gasToken": "0x0000000000000000000000000000000000000000",
        "refundReceiver": "0x0000000000000000000000000000000000000000",
        "nonce": "29"
    }
}

Calldata:
{
  "function": "transfer(address,uint256)",
  "params": [
    "0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045",
    "1000000000000000000"
  ]
}

Result-> approved
````
