defmodule Monerox do
  @moduledoc false

  use Application
  @moduledoc File.read!("#{__DIR__}/../README.md")

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Monerox.Daemon.RPC, []),
      worker(Monerox.Wallet.RPC, []),
    ]

    opts = [strategy: :one_for_one, name: Monerox.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
