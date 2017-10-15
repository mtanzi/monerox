# Monerox

A library for Monero RPC calls written in Elixir.

This library can be used to build application on top of the Monero protocol leveraging on the power of Elixir

This is an evening project I did mostly did for fun so please treat it as a very Alpha version. If anybody would like to contribute, any help would be really appreciated.

## Current status
At the moment there is a subset of RPC call implemented, you can find the description of the implemented call in the modules:

  * [Monerox.Daemon](https://github.com/mtanzi/monerox/blob/master/lib/monerox/daemon.ex)
  * [Monerox.Wallet](https://github.com/mtanzi/monerox/blob/master/lib/monerox/wallet.ex)

## Usage

Add the library in your `deps`.

```elixir
defp deps do
  [{:monerox, "~> 0.1.0"}]
end
```

## Connect to the Daemons
This library need to have both the Daemon RPC and the Wallet RPC client running. You can find the instruction about how to install and start the daemons on the [Monero project](https://github.com/monero-project/monero)

You need to add the configuration for both the clients to define the connections properties.

```elixir
use Mix.Config

config :monerox, :daemon_rpc,
  host: "127.0.0.1",
  port: 18081,
  adapter: Monerox.Daemon.RPC

config :monerox, :wallet_rpc,
  host: "127.0.0.1",
  port: 8082,
  username: System.get_env("WALLET_RPC_USER"),
  password: System.get_env("WALLET_RPC_PASS"),
  adapter: Monerox.Wallet.RPC
```

## Donations
* BTC: `1JErvsedmVpuT3kUsHfZmWFqChFerTBc8f`
* XRM: `43GLcLJZLja2CJujNmFwozWkitV8dBMtEEeESjXLguFdbeTbahqyaBxTGVjv7tPnz47EpBGf5miVsEZFnAXXxC9xNLAM8Ec`

## Licence
See the LICENCE file in the project root.

## Contributing
Please fork this repository to your own account, create a feature/{short but descriptive name} branch on your own
repository and submit a pull request back to develop.
