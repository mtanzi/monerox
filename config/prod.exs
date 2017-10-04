use Mix.Config

config :monerox, :daemon_rpc,
  host: "127.0.0.1",
  port: 18081,
  adapter: Monerox.Daemon.RPC
