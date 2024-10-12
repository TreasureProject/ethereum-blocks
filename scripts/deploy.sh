#!/bin/bash

if [[ $# -lt 1 ]]
then
    echo "Usage: $0 <network> [<subgraph name> <version>]"
    echo
    echo "To build only: supply the <network>."
    echo "To build AND deploy: supply the <network>, <subgraph name>, and <version>."
    echo
    exit
fi

NETWORK=$1

# Generate network-specific files from templates.
mustache configs/${NETWORK}.json subgraph.template.yaml > subgraph.yaml

# Generate code and build.
npx graph codegen
npx graph build

if [[ $# -lt 3 ]]
then
    echo "Usage: $0 <network> [<subgraph name> <version>]"
    echo
    echo "To build AND deploy: supply the <network>, <subgraph name>, and <version>."
    echo
    exit
fi

SUBGRAPH=$2
VERSION=$3

# Deploy.
DEPLOY_KEY=$(grep GOLDSKY_API_KEY .env | cut -d '=' -f2)
goldsky --token ${DEPLOY_KEY} subgraph deploy ${SUBGRAPH}/${VERSION} --path .
goldsky --token ${DEPLOY_KEY} subgraph tag create ${SUBGRAPH}/${VERSION} --tag live
