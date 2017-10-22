defmodule Monerox.Wallet.RPC.Behaviour do
  @moduledoc false

  @type error :: {:error, map() | binary() | atom()}

  # API methods

  @callback getbalance() :: {:ok, binary()} | error
  @callback getaddress() :: {:ok, binary()} | error
  @callback getheight() :: {:ok, binary()} | error
end
