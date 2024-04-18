# SelfDestructMe notes

The only intended method for depositing ETH in the contract is through the `deposit` function.
However, it's possible for ETH to be deposited via `selfdestruct` or by setting this contract as the target of a beacon chain withdrawal (see last paragraph of this section: [Withdrawal Processing](https://eth2book.info/capella/part2/deposits-withdrawals/withdrawal-processing/#performing-withdrawals)),even without a `receive` function.

If ETH is deposited in this alternative manner, the strict equality condition is violated, potentially causing a DoS attack.

To mitigate this, the code could be modified to use >= instead of ==, ensuring that the available ETH balance is at least `totalDeposits`, which aligns better with the intended logic.

# MishandlingOfEth notes

Contract that allows people to pool their money and the contract will send everyone's money back at some point.

The attack here is that when the MishandlingOfEth contract tries to send back Ether to its entrants (including the MishandlingOfEthAttacker contract) using its sendBack function, the transfer will fail because the MishandlingOfEthAttacker contract's receive and fallback functions revert any incoming transfers. This will cause the MishandlingOfEth contract's sendBack function to revert as well due to the require(success) statement, preventing any of the entrants from receiving their Ether back.
