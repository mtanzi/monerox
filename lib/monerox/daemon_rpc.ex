defmodule Monerox.DaemonRPC do
  @moduledoc """
  `Monerox.DaemonRPC` interact with the Monero Deamo RPC calls. Here the list of
  the available calls

    ## RPC
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

  @doc """
  Look up how many blocks are in the longest chain known to the node.

  ## Params
  None

  ## Example:

  iex(41)> Monerox.DaemonRPC.getblockcount
  %{id: "0", jsonrpc: "2.0", result: %{"count" => 1412836, "status" => "OK"}}
  """
  defdelegate getblockcount(), to: Monerox.DaemonRPC.Block, as: :count

  @doc """
  it return the block template from the given wallet_address

  ## Params
  * wallet_address (string): Address of wallet to receive coinbase transactions
    if block is successfully mined.
  * reserve_size (int): Reserve size.

  ## Example
  Monerox.DaemonRPC.getblocktemplate("49oyeH...", 60)
  %{id: "0", jsonrpc: "2.0",
  result: %Monerox.DaemonRPC.BlockTemplate{blocktemplate_blob: "0606fa...",
   difficulty: 30460907885, height: 1412837,
   prev_hash: "e30e4f...",
   reserved_offset: 130}}
  """
  defdelegate getblocktemplate(wallet_address, reverse_size \\ 8), to: Monerox.DaemonRPC.BlockTemplate, as: :get

  @doc """
  It retrieve the header information for the most recent block

  ## Params
  None

  ## Example
  iex(46)> Monerox.DaemonRPC.getlastblockheader
  %{id: "0", jsonrpc: "2.0",
    result: %{block_header: %Monerox.DaemonRPC.BlockHeader{block_size: 305716,
       depth: 0, difficulty: 30423669484,
       hash: "1eca77...",
       height: 1412838, major_version: 6, minor_version: 6, nonce: 1444941736,
       num_txes: 12, orphan_status: false,
       prev_hash: "a13efb...",
       reward: 6568114453628, timestamp: 1507066498}, status: "OK"}}
  """
  defdelegate getlastblockheader(), to: Monerox.DaemonRPC.BlockHeader, as: :get_last

  @doc """
  Fetch the header informations fo the block with the given hash.

  ## Params
  * hash (string): Hash of the block

  ## Example
  iex(47)> Monerox.DaemonRPC.getblockheaderbyhash("1eca77e4de151bc3676377a465ac6ed260fd94124bc123b92c9c2af9316d4c13")
  %{id: "0", jsonrpc: "2.0",
    result: %{block_header: %Monerox.DaemonRPC.BlockHeader{block_size: 305716,
       depth: 0, difficulty: 30423669484,
       hash: "1eca77...",
       height: 1412838, major_version: 6, minor_version: 6, nonce: 1444941736,
       num_txes: 12, orphan_status: false,
       prev_hash: "a13efb...",
       reward: 6568114453628, timestamp: 1507066498}, status: "OK"}}
  """
  defdelegate getblockheaderbyhash(hash), to: Monerox.DaemonRPC.BlockHeader, as: :get_by_hash

  @doc """
  Fetch the header informations fo the block with the given heigh.

  ## Params
  * heigh (string): height of the block

  ## Example
  iex(47)> Monerox.DaemonRPC.getblockheaderbyheight("11412838")
  %{id: "0", jsonrpc: "2.0",
    result: %{block_header: %Monerox.DaemonRPC.BlockHeader{block_size: 305716,
       depth: 0, difficulty: 30423669484,
       hash: "1eca77...",
       height: 1412838, major_version: 6, minor_version: 6, nonce: 1444941736,
       num_txes: 12, orphan_status: false,
       prev_hash: "a13efb...",
       reward: 6568114453628, timestamp: 1507066498}, status: "OK"}}
  """
  defdelegate getblockheaderbyheight(height), to: Monerox.DaemonRPC.BlockHeader, as: :get_by_height

  @doc """
  Fetch the information of the block. it expect a map with either the hash or the
  height of the block

  ## Params
  * %{hash: hash} (map): map conteining the hash of the block
  * %{height: height} (map): map conteining the height of the block

  ## Example
  iex(48)> Monerox.DaemonRPC.getblock(%{hash: "1eca77..."})
  %{id: "0", jsonrpc: "2.0",
    result: %Monerox.DaemonRPC.Block{blob: "060682...",
     block_header: %Monerox.DaemonRPC.BlockHeader{block_size: 305716, depth: 2,
      difficulty: 30423669484,
      hash: "1eca77...", height: 1412838, major_version: 6, minor_version: 6, nonce: 1444941736,
      num_txes: 12, orphan_status: false,
      prev_hash: "a13efb2fb479f0ec33c40d46d8139e9ff752f0c7a6568d30b4b2306e855f29ab",
      reward: 6568114453628, timestamp: 1507066498},
     json: "{\n  \"major_version\": 6, ...",
     status: "OK",
     tx_hashes: ["210abb...", "379f561...", "995731...", "a7e8f7...", cba388...",
     "d82caf...", "0c2fd0...", "076963...", "c375e4...", "5dc993...", "25b2eb...",
     "4510bf..."]}}
  """
  defdelegate getblock(params), to: Monerox.DaemonRPC.Block, as: :get

  @doc """
  Fetch general informations about the state of the node and the network.

  ## Params
  None
  """
  defdelegate get_info(), to: Monerox.DaemonRPC.Info, as: :get

end
