defmodule Monerox.DeamonRPC do

  defdelegate getblockcount(), to: Monerox.DeamonRPC.Block, as: :count

  defdelegate getblocktemplate(wallet_address, reverse_size \\ 8), to: Monerox.DeamonRPC.BlockTemplate, as: :get

  defdelegate getlastblockheader(), to: Monerox.DeamonRPC.BlockHeader, as: :get_last

  defdelegate getblockheaderbyhash(hash), to: Monerox.DeamonRPC.BlockHeader, as: :get_by_hash

  defdelegate getblockheaderbyheight(height), to: Monerox.DeamonRPC.BlockHeader, as: :get_by_height

  defdelegate getblock(params), to: Monerox.DeamonRPC.Block, as: :get

  defdelegate get_info(), to: Monerox.DeamonRPC.Info, as: :get

end
