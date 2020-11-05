# 🧑‍💻 [ADVANCED CHALLENGE] REST APIs - Read an account's pending payouts

## Submission Requirements

Provide a link to a Gist or Github repository that demonstrates a script to calculate pending payouts by sending HTTP requests to a local Sidecar instance.

## Submission

[Script directory](dart_script)

[Gist of dart script](https://gist.github.com/martinloesethjensen/42bae400485d772587504e1efbeefa70)

## Start a Local Kusama Node

Clone [polkadot repo](https://github.com/paritytech/polkadot) and run local kusama node as seen below.

Run with Kusama

```shell
./target/release/polkadot --chain=kusama
```

![local kusama node running](images/local-kusama-node.png)

## Start a Local Sidecar Instance

Clone [sidecar repo](https://github.com/paritytech/substrate-api-sidecar) and run local sidecar instance as seen below.

As I ran it with Docker, then we need to update `.env.docker` with this added `SAS_SUBSTRATE_WS_URL=wss://kusama-rpc.polkadot.io` to it. This is because we will use the Kusama network.

> Follow this section on [how to build and run Sidecar with Docker](https://github.com/paritytech/substrate-api-sidecar#docker).

![local sidecar instance running](images/local-sidecar-instance.png)

## Running Script

Follow the [dart_script README.md](dart_script/README.md) on how to run the script.

![dart script running](images/dart-script.png)
