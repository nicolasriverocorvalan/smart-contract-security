# Puppy Raffle

## Cheat Sheets
* `forge inspect PuppyRaffle methods`

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

### Reentrancy Scenario - Victim

1. Victim deposits 5 eth.

contract balance = 5 ether
UserBalance[Victim] = 5 ether
Victim: -5 ether

2. Attacker call attack function.

a. Attacker deposit 1 ether

UserBalance[Victim] = 5 ether
UserBalance[attacker] = 1 ether
contract balance = 6 ether
Victim: -5 ether
Attacker: -1 ether

b. Attacker call withdrawBalance function.

c. In the middle of withdrawBalance function, the receive function is triggered (call back).

UserBalance[Victim] = 5 ether
UserBalance[attacker] = 1 ether
contract balance = 5 ether
Victim: -5 ether
Attacker: 0 ether

d. Contract attacker, re enters contract and calls withdrawBalance again.

e. In the middle of withdrawBalance function, the receive function is triggered (call back).

UserBalance[Victim] = 5 ether
UserBalance[attacker] = 1 ether
contract balance = 4 ether
Victim: -5 ether
Attacker: 1 ether

f. Only after we steal all the money will the user balance be updated to Zero.

```javascript
userBalance[msg.sender] = 0;
```

UserBalance[Victim] = 5 ether
UserBalance[attacker] = 0 ether
contract balance = 0 ether
Victim: -5 ether
Attacker: 5 ether
