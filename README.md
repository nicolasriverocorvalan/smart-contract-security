# Smart Contract Security

[Web3 Attacks](https://github.com/nicolasriverocorvalan/smart-contract-security/tree/main/attacks)
[Ethernaut with Foundry](https://github.com/nicolasriverocorvalan/smart-contract-security/tree/main/ethernaut)

## Notes
* Before you go to audit must pass [Rekt Test](https://blog.trailofbits.com/2023/08/14/can-you-pass-the-rekt-test/).
* [Solodit](https://solodit.xyz/auth/), all reports in one place.
* ERC721: NFT.
* Toke URI:
  - URI is a string containing characters that identify a physical or logical resource. 
  - It is just a simple API call.
* [CEI/FREI-PI](https://www.nascent.xyz/idea/youre-writing-require-statements-wrong)

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

## Smart Contract Devops

* ERC-2335: Keystore

### Multi-sig wallet

* Is a smart contract that governs transactions. These can be setup so that they require several people to sign a transaction for it to go though.
* You can customize these so that any X number of people are required to sign before a transaction is submitted out of Y. Example, if a 3 people are needed to sign out of a possible 5 people, this is a known as "3-of-5 wallet".
* Weak support for web3 apps.
* Gas cost.

### Social Recovery

* There is a single "signing key" that can be used to approve transactions.
* There is a set of at least 3 (or much higher number) of "guardians", of which a majority can cooperate to change the signing key of the account.
* Users could also use a Shamir backup, similar to social recovery. You give out "shares" of your key to trusted users, where you can recovery your key  when the shares are combined. A recovery share is usually a sequence of 20/33 English words carrying a part of the cryptographic secret.

### Tools

#### Monitoring

- [Forta](https://www.youtube.com/watch?v=42RcaQ8YTzQ)
- [Pessimistic Spotter](https://spotter.pessimistic.io/#form)
- [OZ Defender](https://defender.openzeppelin.com/#/sentinel)

#### Risk economics

- [Gauntlet](https://www.gauntlet.xyz/)
- [Chaos Labs](https://chaoslabs.xyz/)

#### Incident Response

- [SEAL](https://form.typeform.com/to/jJoH2ktE?typeform-source=securityalliance.org)
  - [SEAL Drills](https://securityalliance.notion.site/Live-Scenario-Documentation-520e7db48e2143f7bc41b729fb219996)
  - [Wargames](https://form.typeform.com/to/jJoH2ktE?typeform-source=securityalliance.org)
  - [Safe Harbor](https://github.com/security-alliance/safe-harbor)
  - [SEAL 911](https://t.me/seal_911_bot)

#### Bug bounties platforms

- [Immunefi](https://immunefi.com/)
- [Hats Finance](https://hats.finance/)

#### Blockchain sleuthing

- [OpenChain](https://openchain.xyz/)
- [Phalcon](https://phalcon.xyz/)
- [Tenderly](https://tenderly.co/)
- [Metadoc](https://blocksec.com/metadock)
- [Dune analytics](https://dune.com/browse/dashboards)
- [GhostLogs](https://ghostlogs.xyz/)
- [shadow.xyz](https://www.shadow.xyz/)
