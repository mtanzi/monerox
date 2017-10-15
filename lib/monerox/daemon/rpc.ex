defmodule Monerox.Daemon.RPC do
  @moduledoc """
  Daemon.RPC is used to connect and make RPC call to the monero daemon.

  The client use the Monero.RPC module where are described all the functions needed
  to connect to the RPC daemon. The macro expect a keyword list with all the
  configuration files.

  In the configuration file we need to define the host and port where the RPC
  daemon is running and the adapter used.

    # Example

      config :monerox, :daemon_rpc,
        host: "127.0.0.1",
        port: 18081,
        adapter: Monerox.Daemon.RPC
  """

  use Monerox.RPC, Application.get_env(:monerox, :daemon_rpc)

end
