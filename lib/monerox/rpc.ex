defmodule Monerox.RPC do

  defdelegate getlastblockheader(), to: Monerox.RPC.BlockHeader, as: :get_last

  defdelegate getblocktemplate(wallet_address, reverse_size \\ 8), to: Monerox.RPC.BlockTemplate, as: :get

  defdelegate getblockheaderbyhash(hash), to: Monerox.RPC.BlockHeader, as: :get_by_hash

  defdelegate getblockheaderbyheight(height), to: Monerox.RPC.BlockHeader, as: :get_by_height

  defdelegate getblock(height), to: Monerox.RPC.Block, as: :get

end
