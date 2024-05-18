import os
from web3 import Web3, HTTPProvider
from dotenv import load_dotenv
import time

# Load environment variables
load_dotenv()

private_key = os.getenv('PRIVATE_KEY')

# Connect to Ethereum node
endpoint = os.getenv('INFURA_RPC_URL')
w3 = Web3(HTTPProvider(endpoint))

# Set the default account
account = os.getenv('ACCOUNT_ADDRESS')
w3.eth.default_account = account

# Contract ABI
abi = [
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_coinFlipAddress",
				"type": "address"
			}
		],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"inputs": [],
		"name": "play",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "predict",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]

# Contract address
contract_address = os.getenv('CONTRACT_ADDRESS')

# Create contract object
contract = w3.eth.contract(address=contract_address, abi=abi)

for i in range(10):
    # Build a transaction
    transaction = contract.functions.play().build_transaction({
        'from': account,
        'nonce': w3.eth.get_transaction_count(account) + i,
        'gasPrice': int(w3.eth.gas_price * 1.1),
    })

    # Sign the transaction
    signed_txn = w3.eth.account.sign_transaction(transaction, private_key)

    # Send the transaction
    tx_hash = w3.eth.send_raw_transaction(signed_txn.rawTransaction)

    # Wait for the transaction to be mined
    tx_receipt = w3.eth.wait_for_transaction_receipt(tx_hash)

    print(f'Transaction {i+1} successful with gas used: {tx_receipt["gasUsed"]}')

    time.sleep(15)
