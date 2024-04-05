# smart-contract-security

## Rekt test
Before you go to audit must pass [Rekt Test](https://blog.trailofbits.com/2023/08/14/can-you-pass-the-rekt-test/).

## Notes
* ERC721: NFT.
* Toke URI:
  - URI is a string containing characters that identify a physical or logical resource. 
  - It is just a simple API call.

### Fuzzing/Invariant test
* random inputs
* Stateful fuzzing: fuzzing where the final state of your previous run is the starting state of your next run.
* In Foundry:
  - Fuzzing test: Random data to one function (stateless).
  - Invariant test: Random data and random function calls to many functions (stateful).

## Phases

1. Scoping
   * [cloc](https://github.com/AlDanial/cloc)
2. Recon
   * Context: VSCode plugin: Solidity metrics (+ Scoping).
   * Understanding the code.
3. Exploit
   * Access control.
   * Public data.
4. Test
5. Report
   * [Finding severity](https://docs.codehawks.com/hawks-auditors/how-to-evaluate-a-finding-severity)

## Security Toolkit
* https://github.com/nascentxyz/simple-security-toolkit

### Static Analysis
* Slither
* Aderyn
* Mythril

## Docs
* https://github.com/ZhangZhuoSJTU/Web3Bugs (machine auditable vs unauditable)

## Web3 newsletters

Cyfrin Updraft
* [Blockchain Threat Intelligence](https://newsletter.blockthreat.io/)
* [Solodit](https://solodit.xyz/)
* [Rekt](https://rekt.news/)
* [Week In Ethereum](https://weekinethereumnews.com/)
* [Consensys Diligence Newsletter](https://consensys.io/diligence/newsletter/)
* [Officer CIA](https://officercia.mirror.xyz/)

## Findings template (101)

```
## [Severity-#] TITLE (Root couse + Impact)

### Description

### Impact

### Proof of Concept

### Recommended Mitigation

```

## Cheat sheet

* `forge test --mt test_anyone_can_set_password`
* `forge test --mt testReentrancyRefund  -vvv`
* `slither .`
* `aderyn --root .`
