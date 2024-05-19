import os
import time
import json
from web3 import Web3, HTTPProvider
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

private_key = os.getenv('PRIVATE_KEY')
endpoint = os.getenv('INFURA_RPC_URL')
account = os.getenv('ACCOUNT_ADDRESS')
contract_address = os.getenv('CONTRACT_ADDRESS')

# Connect to Ethereum node
w3 = Web3(HTTPProvider(endpoint))

# Set the default account
w3.eth.default_account = account

# Load Contract ABI
with open('contract-abi.json', 'r') as file:
    abi = json.load(file)

# Create contract object
contract = w3.eth.contract(address=contract_address, abi=abi)

def send_transaction(contract_function, params):
    try:
        # Build a transaction
        transaction = contract_function.build_transaction(params)

        # Sign the transaction
        signed_txn = w3.eth.account.sign_transaction(transaction, private_key)

        # Send the transaction
        tx_hash = w3.eth.send_raw_transaction(signed_txn.rawTransaction)

        # Wait for the transaction to be mined
        tx_receipt = w3.eth.wait_for_transaction_receipt(tx_hash)

        print(f'Transaction successful with gas used: {tx_receipt["gasUsed"]}')
    except Exception as e:
        print(f'Error sending transaction: {e}')

for i in range(10):
    params = {
        'from': account,
        'nonce': w3.eth.get_transaction_count(account) + i,
        'gasPrice': int(w3.eth.gas_price * 1.1),
    }
    send_transaction(contract.functions.attack(), params)
    time.sleep(15)
