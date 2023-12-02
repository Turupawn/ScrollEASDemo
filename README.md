![test workflow](https://github.com/Turupawn/ScrollEASDemo/actions/workflows/test.yml/badge.svg)

# Scroll Sepila Ethereum Attestation Service (EAS) Demo

This repo includes a foundry test and script that uses EAS deployment on Scroll Sepolia. You can use this repo to explore the EAS usage and also as a recommended way of implementing EAS on Foundry.

Forks and PRs very welcome!

## ✅ Running the test

The testing script creates a Schema and makes an attestation:

```bash
forge test --fork-url https://sepolia-rpc.scroll.io/
```

## 🚀 Running the script on-chin

Creates an attestation on Scroll Sepolia on an already existing Schema.

```bash
PRIVATE_KEY="YOURPRIVATEKEYHERE" forge script script/Attester.s.sol:MyScript --fork-url https://sepolia-rpc.scroll.io/ --broadcast --legacy
```

This should print something similar to this in the terminal:

```bash
You created the following Attester contract:
0x6Be4263881d10b8eA2daE2c9ad6a3DA506804125
You submitted the following Attestestation:
0x19dc05d87493c8f814c3672076c5d0e16cd2b2614f68695f1bbc6ffecda1cee9
```

You can query the Attester contract and the Attestation on [Scroll Sepolia EASScan](https://scroll-sepolia.easscan.org/).
