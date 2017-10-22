defmodule Monerox.Daemon.RPC.Behaviour do
  @moduledoc false

  @type error :: {:error, map() | binary() | atom()}

  # API methods

  @callback getblockcount() :: {:ok, binary()} | error
  @callback on_getblockhash(integer()) :: {:ok, binary()} | error
  @callback submitblock(binary()) :: {:ok, binary()} | error
  @callback getblocktemplate(binary(), integer()) :: {:ok, binary()} | error
  @callback getlastblockheader() :: {:ok, binary()} | error
  @callback getblockheaderbyhash(binary()) :: {:ok, binary()} | error
  @callback getblockheaderbyheight(binary()) :: {:ok, boolean()} | error
  @callback getblock(map()) :: {:ok, binary()} | error
  @callback get_info() :: {:ok, binary()} | error
  @callback hard_fork_info() :: {:ok, binary()} | error
end
