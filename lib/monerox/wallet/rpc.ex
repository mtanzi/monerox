defmodule Monerox.Wallet.RPC do
  @moduledoc """
  Wallet.RPC is used to connect and make RPC call against the monero wallet daemon.
  The client support all the JSON RPC methods described in the documentation.

  The client use the Monero.RPC module where are described all the functions used
  to connect to the RPC daemon. The macro expect a keyword list with all the
  configuration files.

  In the configuration file we need to define the host and port where the wallet
  daemon is running, the username and password to connect to the wallet and the
  adapter used.

    # Example

      config :monerox, :wallet_rpc,
        host: "127.0.0.1",
        port: 8082,
        username: "RPC-DAEMON-USERNAME",
        password: "RPC-DAEMON-PASSWORD",
        adapter: Monerox.Wallet.RPC
  """

  use Monerox.RPC, Application.get_env(:monerox, :wallet_rpc)

end
