defmodule Monerox.Daemon do
  @moduledoc """
  `Monerox.Daemon` interact with the Monero RPC Deamon. Here the list of
  the available calls

    # RPC
      * getblockcount/0
      * on_getblockhash/1
      * submitblock/1
      * getblocktemplate/2
      * getlastblockheader/0
      * getblockheaderbyhash/1
      * getblockheaderbyheight/1
      * getblock/1
      * get_info/0
      * hard_fork_info/0

    TODO:
      * setbans
      * getbans
  """

  @doc """
  Look up how many blocks are in the longest chain known to the node.

  # Params

    None

  # Example:

    iex(24)> Monerox.Daemon.getblockcount
    %{"id" => 15, "jsonrpc" => "2.0", "result" => %{"count" => 1425545, "status" => "OK"}}
  """
  defdelegate getblockcount(), to: Monerox.Daemon.RPC

  @doc """
  it return the block hash from the given height.

  # Params

    * height

  # Example:
    iex(6)> Monerox.Daemon.on_getblockhash(1425668)
    %{"id" => 4, "jsonrpc" => "2.0",
      "result" => "eee551da136407fe9fad950bdf0f5da58cbc878103cc0ae1e2a0a0cde4d459bc"}
  """
  defdelegate on_getblockhash(height), to: Monerox.Daemon.RPC

  @doc """
  submit a block

  # Params

    * blob

  # Example:
    iex(6)> Monerox.Daemon.submitblock(blob)
      %{"error" => %{"code" => -7, "message" => "Block not accepted"}, "id" => 8,
        "jsonrpc" => "2.0"}
  """
  defdelegate submitblock(blob), to: Monerox.Daemon.RPC

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
  defdelegate getblocktemplate(wallet_address, reverse_size \\ 8), to: Monerox.Daemon.RPC

  @doc """
  It retrieve the header information for the most recent block

  # Params

    None

  # Example

    iex(26)> Monerox.Daemon.getlastblockheader
    %{"id" => 16, "jsonrpc" => "2.0",
    "result" => %{"block_header" => %{"block_size" => 95, "depth" => 0,
        "difficulty" => 27961225936,
        "hash" => "9b431bc8df3142a0fc0c9fb79c0a52cab12801c9a5a7d9a60c82b885c8f22623",
        "height" => 1425545, "major_version" => 6, "minor_version" => 6,
        "nonce" => 8445, "num_txes" => 0, "orphan_status" => false,
        "prev_hash" => "9a9b982086b88211af6b1f943551ff1aa25c627a27f95088d126180d9a2c53f1",
        "reward" => 6101648255431, "timestamp" => 1508595292}, "status" => "OK"}}
  """
  defdelegate getlastblockheader(), to: Monerox.Daemon.RPC

  @doc """
  Fetch the header informations fo the block with the given hash.

  # Params

    * hash (string): Hash of the block

  # Example

    iex(29)> Monerox.Daemon.getblockheaderbyhash("9b431bc8df3142a0fc0c9fb79c0a52cab12801c9a5a7d9a60c82b885c8f22623")
    %{"id" => 17, "jsonrpc" => "2.0",
    "result" => %{"block_header" => %{"block_size" => 95, "depth" => 1,
        "difficulty" => 27961225936,
        "hash" => "9b431bc8df3142a0fc0c9fb79c0a52cab12801c9a5a7d9a60c82b885c8f22623",
        "height" => 1425545, "major_version" => 6, "minor_version" => 6,
        "nonce" => 8445, "num_txes" => 0, "orphan_status" => false,
        "prev_hash" => "9a9b982086b88211af6b1f943551ff1aa25c627a27f95088d126180d9a2c53f1",
        "reward" => 6101648255431, "timestamp" => 1508595292}, "status" => "OK"}}
  """
  defdelegate getblockheaderbyhash(hash), to: Monerox.Daemon.RPC

  @doc """
  Fetch the header informations fo the block with the given height.

  # Params

    * height (string): height of the block

  # Example

    iex(31)> Monerox.Daemon.getblockheaderbyheight(1425545)
    %{"id" => 19, "jsonrpc" => "2.0",
    "result" => %{"block_header" => %{"block_size" => 95, "depth" => 1,
        "difficulty" => 27961225936,
        "hash" => "9b431bc8df3142a0fc0c9fb79c0a52cab12801c9a5a7d9a60c82b885c8f22623",
        "height" => 1425545, "major_version" => 6, "minor_version" => 6,
        "nonce" => 8445, "num_txes" => 0, "orphan_status" => false,
        "prev_hash" => "9a9b982086b88211af6b1f943551ff1aa25c627a27f95088d126180d9a2c53f1",
        "reward" => 6101648255431, "timestamp" => 1508595292}, "status" => "OK"}}
  """
  defdelegate getblockheaderbyheight(height), to: Monerox.Daemon.RPC

  @doc """
  Fetch the information of the block. it expect a map with either the hash or the
  height of the block

  # Params

    * %{hash: hash} (map): map conteining the hash of the block
    * %{height: height} (map): map conteining the height of the block

  # Example

    iex(32)> Monerox.Daemon.getblock(%{hash: "9b431bc8df3142a0fc0c9fb79c0a52cab12801c9a5a7d9a60c82b885c8f22623"})
    %{"id" => 20, "jsonrpc" => "2.0",
    "result" => %{"blob" => "0606dcacad...",
      "block_header" => %{"block_size" => 95, "depth" => 2,
        "difficulty" => 27961225936,
        "hash" => "9b431bc8df3142a0fc0c9fb79c0a52cab12801c9a5a7d9a60c82b885c8f22623",
        "height" => 1425545, "major_version" => 6, "minor_version" => 6,
        "nonce" => 8445, "num_txes" => 0, "orphan_status" => false,
        "prev_hash" => "9a9b982086b88211af6b1f943551ff1aa25c627a27f95088d126180d9a2c53f1",
        "reward" => 6101648255431, "timestamp" => 1508595292},
      "json" => "{...}",
      "status" => "OK"}}
  """
  defdelegate getblock(params), to: Monerox.Daemon.RPC

  @doc """
  Fetch general informations about the state of the node and the network.

  # Params

    None

  # Example

    iex(22)> Monerox.Daemon.get_info()
    %{"id" => 14, "jsonrpc" => "2.0",
    "result" => %{"alt_blocks_count" => 0, "block_size_limit" => 600000,
      "cumulative_difficulty" => 4244506459638282, "difficulty" => 27961225936,
      "grey_peerlist_size" => 1913, "height" => 1425545,
      "incoming_connections_count" => 0, "outgoing_connections_count" => 8,
      "start_time" => 1508592687, "status" => "OK", "target" => 120,
      "target_height" => 0, "testnet" => false,
      "top_block_hash" => "9a9b982086b88211af6b1f943551ff1aa25c627a27f95088d126180d9a2c53f1",
      "tx_count" => 1792596, "tx_pool_size" => 0, "white_peerlist_size" => 42}}
  """
  defdelegate get_info(), to: Monerox.Daemon.RPC

  @doc """
  Return the informations about the hard fork.

  # Params

    None

  # Example

    iex(15)> Monerox.Daemon.hard_fork_info
    %{"id" => 9, "jsonrpc" => "2.0",
    "result" => %{"earliest_height" => 1400000, "enabled" => true, "state" => 2,
      "status" => "OK", "threshold" => 0, "version" => 6, "votes" => 10080,
      "voting" => 6, "window" => 10080}}
  """
  defdelegate hard_fork_info(), to: Monerox.Daemon.RPC
end
