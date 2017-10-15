use Mix.Config

config :monerox, :daemon_rpc,
  host: "127.0.0.1",
  port: 18081,
  adapter: Monerox.Daemon.RPCMock
<<<<<<< HEAD

config :monerox, :wallet_rpc,
  host: "127.0.0.1",
  port: 8082,
  username: "test",
  password: "test",
  adapter: Monerox.Daemon.RPCMock
=======
>>>>>>> 38d632d... refactored daemon structure and added tests
