# btcs

Some bitcoin core scripts. All sh scripts are posix compliant.

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
