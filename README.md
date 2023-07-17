# ethereum-blocks

A subgraph to index blocks on the network.

Example for the `sepolia` network.
* To build only: `npm run build-sepolia`
* To build AND deploy: `npm run deploy-sepolia`.

If you want to deploy this on a new network `{network}`:
1. Add a new config `configs/{network}.json`.
1. Update the `package.json` to include new `build-{network}` and `deploy-{network}` commands.
