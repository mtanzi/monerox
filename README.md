# Monerox

A library for Monero RPC written in Elixir.

This library can be used to build application on to of the Monero protocol (ex. mining pool, wallet, etc.) using the power of Elixir

This is an evening project so please treat it as a very Alpha version. If anybody would like to contribute, any help would be really appreciated.

## Daemon RPC
List of RPC calls to interact to the Monero daemon -  [documentation](https://getmonero.org/resources/developer-guides/daemon-rpc.html#submitblock)

- [x] getblockcount
- [x] getblocktemplate
- [x] getlastblockheader
- [x] getblockheaderbyhash
- [x] getblockheaderbyheight
- [x] getblock
- [x] get_info

TODO
- [ ] on_getblockhash
- [ ] submitblock
- [ ] hard_fork_info
- [ ] setbans
- [ ] getbans

## Wallet RPC
