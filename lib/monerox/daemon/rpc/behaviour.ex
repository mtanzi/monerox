defmodule Monerox.Daemon.RPC.Behaviour do
  @moduledoc false
  @type error :: {:error, map() | binary() | atom()}


  @moduledoc """
  `Monerox.Daemon` interact with the Monero RPC Deamon. Here the list of
  the available calls

    # RPC
      * getblockcount/0
      * getblocktemplate/2
      * getlastblockheader/0
      * getblockheaderbyhash/1
      * getblockheaderbyheight/1
      * getblock/1
      * get_info/0

    TODO:
      * on_getblockhash
      * submitblock
      * hard_fork_info
      * setbans
      * getbans
"""

  # API methods

  @callback getblockcount() :: {:ok, binary()} | error
  @callback getblocktemplate(binary(), integer()) :: {:ok, binary()} | error
  @callback getlastblockheader() :: {:ok, binary()} | error
  @callback getblockheaderbyhash(binary()) :: {:ok, binary()} | error
  @callback getblockheaderbyheight(binary()) :: {:ok, boolean()} | error
  @callback getblock(map()) :: {:ok, binary()} | error
  @callback get_info() :: {:ok, binary()} | error

end
