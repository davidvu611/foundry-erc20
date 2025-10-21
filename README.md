## Requirements
- [foundry](https://getfoundry.sh/)
  - You'll know you did it right if you can run `forge --version` and you see a response like `forge 1.3.5-stable`

## Quickstart

```
cd foundry-erc20
make build
```
# Usage

## Install library and tools
```
make clean install
```

## Build
```
make build
```

## Deploy
Deloy to your local.
```
make deploy
```

Deloy to sepolia (fork)
```
make deploy-sepolia
```

## Testing

```
forge test
```

or

```
forge test --fork-url $SEPOLIA_RPC_URL
```

### Test Coverage

```
forge coverage
```

# Deployment to a testnet or mainnet

1. Setup environment variables

- Add environmet varriables to a `.env` file
    RPC_URL=http://localhost:8545
    SEPOLIA_RPC_URL=https://eth-sepolia.g.alchemy.com/v2/xxxxxxxxxxxxx
    ETHERSCAN_API_KEY=xxxxxxxxxxxxxxxxxx

- `SEPOLIA_RPC_URL`: This is url of the sepolia testnet node you're working with.
- `ETHERSCAN_API_KEY` if you want to verify your contract on [Etherscan](https://etherscan.io/).

2. Get testnet ETH

Head over to https://cloud.google.com/application/web3/faucet/ethereum and get some testnet ETH. You should see the ETH show up in your metamask.

2. Deploy

```
make deploy ARGS="--network sepolia"
```

## Estimate gas

You can estimate how much gas things cost by running:

```
forge snapshot
```

And you'll see an output file called `.gas-snapshot`

# Formatting

To run code formatting:

```
forge fmt
```

# Thank Patrick Collins!

If you appreciated this, feel free to follow Patrick Collins or donate!

ETH/Arbitrum/Optimism/Polygon/etc Address: 0x9680201d9c93d65a3603d2088d125e955c73BD65

[![Patrick Collins Twitter](https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/PatrickAlphaC)
[![Patrick Collins YouTube](https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/channel/UCn-3f8tw_E1jZvhuHatROwA)
[![Patrick Collins Linkedin](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/patrickalphac/)
[![Patrick Collins Medium](https://img.shields.io/badge/Medium-000000?style=for-the-badge&logo=medium&logoColor=white)](https://medium.com/@patrick.collins_58673/)