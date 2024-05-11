# btcs

Some bitcoin core scripts. All sh scripts are posix compliant.

| Action | Description |
| --- | --- |
| `binary-to-words` | convert list of 0's and 1's to bip39 words calculating checksum |
| `derive-addresses` | derive addresses from descriptor wallet |
| `extended-key-convert` | convert between xpub, ypub, zpub and xprv, yprv, zprv |
| `extended-key-path` | get extended key from descriptor wallet |
| `import-taproot-descriptor` | import a taproot descriptor creating a new wallet |
| `import-wallet-descriptor-multi` | import a multisig wallet creating a new wallet |
| `import-wallet-descriptor-private` | import a wallet with private keys creating a new wallet |
| `import-wallet-descriptor-public` | import a wallet without private keys creating a new wallet |
| `info-address` | print info about an address (should be present in a wallet) |
| `info-tx` | print info about a transaction |
| `list-transactions` | print transactions of a wallet |
| `list-unspent` | print unspent utxo of a wallet |
| `received-by-address` | getreceivedbyaddress searching all wallets |
| `sign-message` | use bitscriptc to sign a message with an address |
| `tx-fee` | print info about the fee of a transaction |

## Installation and usage

To use it without insallation:
```
export BTC_BIN=<bitcoin-cli-bin>

./btcs --help
```

To install it so that can be used from everywhere.

Will install scripts in `~/.local/share/btcs` and a simple wrapper around
btcs that sets `BTC_BIN` named `<name-of-the-script>` in `~/.local/bin`
```
BTCS_NAME=<name-of-the-script> BTC_BIN=<bitcoin-cli-bin> make install

<name-of-the-script> --help
```
Then `<name-of-the-script>` can be executed from everywhere (if
`~/.local/bin` is in your `PATH`)

If you have multiple bitcoin core in the same machine, or the same
binary with different arguments, for example mainnet and testnet
(`BTC_BIN="<bitcoin-cli-bin> --testnet"`):
```
make install-data
BTCS_NAME=<name-of-the-first-script> BTC_BIN=<first-bitcoin-cli-bin> make install-script
BTCS_NAME=<name-of-the-second-script> BTC_BIN=<second-bitcoin-cli-bin> make install-script

<name-of-the-first-script> --help
<name-of-the-second-script> --help
```

Source completions/btcs.bash-completion in `~/.bashrc`

If the bash completion package is installed there are better completions

## License

btcs is released under the terms of the ISC license.
See [LICENSE](LICENSE) for more details.
