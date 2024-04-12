# Puppy Raffle

## Cheat Sheets
* `forge inspect PuppyRaffle methods`

```javascript
# chisel 
Welcome to Chisel! Type `!help` to show available commands.
➜ type(uint64).max
Type: uint64
├ Hex: 0xffffffffffffffff
├ Hex (full word): 0x000000000000000000000000000000000000000000000000ffffffffffffffff
└ Decimal: 18446744073709551615
```

## Attack Scenarios

### Normal Scenario - UserA

0. UserA: 10 ether
1. deposit{value: 10 ether}

userBalance[UserA] = 10 ether
contract balance = 10 ether
UserA: 0 ether

2. withdrawBalance

userBalance[UserA] = 0 ether
contract balance = 0 ether
UserA: 10 ether

### Reentrancy Scenario - victim

1. victim deposits 5 ether.

contract balance = 5 ether
userBalance[victim] = 5 ether
victim: -5 ether

2. Attacker calls attack function.

a. Attacker deposit 1 ether.

userBalance[victim] = 5 ether
userBalance[attacker] = 1 ether
contract balance = 6 ether
victim: -5 ether
Attacker: -1 ether

b. Attacker calls withdrawBalance function.

c. In the middle of withdrawBalance function, the receive function is triggered (call back).

userBalance[victim] = 5 ether
userBalance[attacker] = 1 ether
contract balance = 5 ether
victim: -5 ether
Attacker: 0 ether

d. Contract attacker, re enters contract and calls withdrawBalance again.

e. In the middle of withdrawBalance function, the receive function is triggered (call back).

userBalance[victim] = 5 ether
userBalance[attacker] = 1 ether
contract balance = 4 ether
victim: -5 ether
Attacker: 1 ether

f. Only after we steal all the money will the user balance be updated to zero.

```javascript
userBalance[msg.sender] = 0;
```

userBalance[victim] = 5 ether
userBalance[attacker] = 0 ether
contract balance = 0 ether
victim: -5 ether
Attacker: 5 ether
