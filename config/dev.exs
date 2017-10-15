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
