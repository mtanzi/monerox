defmodule Monerox.Daemon do
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

  @doc """
  Look up how many blocks are in the longest chain known to the node.

  # Params

    None

  # Example:

    iex> Monerox.Daemon.getblockcount()
    %{id: "0", jsonrpc: "2.0", result: %{"count" => 1412836, "status" => "OK"}}
  """
  defdelegate getblockcount(), to: Monerox.Daemon.Block, as: :count

  @doc """
  it return the block template from the given wallet_address

  # Params

    * wallet_address (string): Address of wallet to receive coinbase transactions
      if block is successfully mined.
    * reserve_size (int): Reserve size.

  # Example

    iex> Monerox.Daemon.getblocktemplate("49oyeH...", 60)
    %{id: "0", jsonrpc: "2.0",
    result: %Monerox.Daemon.BlockTemplate{blocktemplate_blob: "0606fa...",
     difficulty: 30460907885, height: 1412837,
     prev_hash: "e30e4f...",
     reserved_offset: 130}}
  """
  defdelegate getblocktemplate(wallet_address, reverse_size \\ 8), to: Monerox.Daemon.BlockTemplate, as: :get

  @doc """
  It retrieve the header information for the most recent block

  # Params

    None

  # Example

    iex> Monerox.Daemon.getlastblockheader()
    %{id: "0", jsonrpc: "2.0",
      result: %{block_header: %Monerox.Daemon.BlockHeader{block_size: 305716,
         depth: 0, difficulty: 30423669484,
         hash: "1eca77...",
         height: 1412838, major_version: 6, minor_version: 6, nonce: 1444941736,
         num_txes: 12, orphan_status: false,
         prev_hash: "a13efb...",
         reward: 6568114453628, timestamp: 1507066498}, status: "OK"}}
  """
  defdelegate getlastblockheader(), to: Monerox.Daemon.BlockHeader, as: :get_last

  @doc """
  Fetch the header informations fo the block with the given hash.

  # Params

    * hash (string): Hash of the block

  # Example

    iex> Monerox.Daemon.getblockheaderbyhash("1eca77e4de151bc3676377a465ac6ed260fd94124bc123b92c9c2af9316d4c13")
    %{id: "0", jsonrpc: "2.0",
      result: %{block_header: %Monerox.Daemon.BlockHeader{block_size: 305716,
         depth: 0, difficulty: 30423669484,
         hash: "1eca77...",
         height: 1412838, major_version: 6, minor_version: 6, nonce: 1444941736,
         num_txes: 12, orphan_status: false,
         prev_hash: "a13efb...",
         reward: 6568114453628, timestamp: 1507066498}, status: "OK"}}
  """
  defdelegate getblockheaderbyhash(hash), to: Monerox.Daemon.BlockHeader, as: :get_by_hash

  @doc """
  Fetch the header informations fo the block with the given heigh.

  # Params

    * heigh (string): height of the block

  # Example

    iex> Monerox.Daemon.getblockheaderbyheight("11412838")
    %{id: "0", jsonrpc: "2.0",
      result: %{block_header: %Monerox.Daemon.BlockHeader{block_size: 305716,
         depth: 0, difficulty: 30423669484,
         hash: "1eca77...",
         height: 1412838, major_version: 6, minor_version: 6, nonce: 1444941736,
         num_txes: 12, orphan_status: false,
         prev_hash: "a13efb...",
         reward: 6568114453628, timestamp: 1507066498}, status: "OK"}}
  """
  defdelegate getblockheaderbyheight(height), to: Monerox.Daemon.BlockHeader, as: :get_by_height

  @doc """
  Fetch the information of the block. it expect a map with either the hash or the
  height of the block

  # Params

    * %{hash: hash} (map): map conteining the hash of the block
    * %{height: height} (map): map conteining the height of the block

  # Example

    iex> Monerox.Daemon.getblock(%{hash: "1eca77..."})
    %{id: "0", jsonrpc: "2.0",
      result: %Monerox.Daemon.Block{blob: "060682...",
       block_header: %Monerox.Daemon.BlockHeader{block_size: 305716, depth: 2,
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
  defdelegate getblock(params), to: Monerox.Daemon.Block, as: :get

  @doc """
  Fetch general informations about the state of the node and the network.

  # Params

    None

  # Example

    iex> Monerox.Daemon.get_info()
    %{id: "0", jsonrpc: "2.0",
      result: %Monerox.Daemon.Info{alt_blocks_count: 0, block_size_limit: 600000,
       cumulative_difficulty: 4109981961448388, difficulty: 30473420047,
       grey_peerlist_size: 2227, height: 1421112, incoming_connections_count: 0,
       outgoing_connections_count: 8, start_time: 1508055160, status: "OK",
       target: 120, target_height: 1421063, testnet: false,
       top_block_hash: "da3a899b479c8a19d138b658883c539da899b99fd4da3b90da7024e981b13a56",
       tx_count: 1767633, tx_pool_size: 6, white_peerlist_size: 92}}
  """
  defdelegate get_info(), to: Monerox.Daemon.Info, as: :get

end
