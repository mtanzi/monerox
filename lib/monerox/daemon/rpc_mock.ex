defmodule Monerox.Daemon.RPCMock do

  def call("getblockcount"), do: block_count()
  def call("getlastblockheader"), do: block_header()
  def call("get_info"), do: info()

  def call("getblockheaderbyhash", %{hash: "hash-1111"}), do: block_header()
  def call("getblockheaderbyheight", %{height: 1234}), do: block_header()
  def call("getblock", %{hash: "hash-1111"}), do: block()
  def call("getblock", %{height: 1234}), do: block()

  def call("getblocktemplate", %{wallet_address: "my-wallet-address", reserve_size: 60}), do: block_template()

  defp block_count() do
    %{
      id: "0",
      jsonrpc: "2.0",
      result: %{
        "count" => 1413535,
        "status" => "OK"
      }
    }
  end

  defp block_template() do
    %{
      id: "0",
      jsonrpc: "2.0",
      result: %Monerox.Daemon.BlockTemplate{
        blocktemplate_blob: "blob-1111",
        difficulty: 300000000,
        height: 1234,
        prev_hash: "hash-1111",
        reserved_offset: 130
      }
    }
  end

  def header() do
    %Monerox.Daemon.BlockHeader{
      block_size: 1234,
      depth: 0, difficulty: 300000000,
      hash: "hash-2222",
      height: 1234, major_version: 6, minor_version: 6, nonce: 3288386599,
      num_txes: 2, orphan_status: false,
      prev_hash: "hash-1111",
      reward: 6296911737749, timestamp: 1507151548 |> DateTime.from_unix!
    }
  end

  defp block_header() do
    %{
      id: "0",
      jsonrpc: "2.0",
      result: %{
        block_header: header(),
        status: "OK"
      }
    }
  end

  defp block() do
    %{
      id: "0",
      jsonrpc: "2.0",
      result: %Monerox.Daemon.Block{
        blob: "blob-1111",
        block_header: header(),
        json: "{...}",
        status: "OK",
        tx_hashes: ["tx-1","tx-2"]
      }
    }
  end

  defp info() do
    %{id: "0",
      jsonrpc: "2.0",
      result: %Monerox.Daemon.Info{
        alt_blocks_count: 0,
        block_size_limit: 600000,
        cumulative_difficulty: 3874296726055158,
        difficulty: 29895986894,
        grey_peerlist_size: 1870,
        height: 1413546,
        incoming_connections_count: 0,
        outgoing_connections_count: 8,
        start_time: 1507149950,
        status: "OK",
        target: 120,
        target_height: 1413530,
        testnet: false,
        top_block_hash: "top-hash-1",
        tx_count: 1726933,
        tx_pool_size: 4,
        white_peerlist_size: 27
      }
    }
  end
end
