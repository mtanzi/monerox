defmodule Monerox.RPC do

  defdelegate getblockcount(), to: Monerox.RPC.GetBlockCount, as: :call

  defdelegate on_getblockhash(height), to: Monerox.RPC.OnGetBlockHash, as: :call

  defdelegate getblocktemplate(wallet_address, reverse_size \\ 8), to: Monerox.RPC.BlockTemplate, as: :get

  defdelegate submitblock(blob), to: Monerox.RPC.Block, as: :submit

  defdelegate getlastblockheader(), to: Monerox.RPC.BlockHeader, as: :get_last

  defdelegate getblockheaderbyhash(hash), to: Monerox.RPC.BlockHeader, as: :get_by_hash

  defdelegate getblockheaderbyheight(height), to: Monerox.RPC.BlockHeader, as: :get_by_height

  defdelegate getblock(params), to: Monerox.RPC.Block, as: :get

end
