defmodule DeamonTest do
  use ExUnit.Case
  doctest Monerox

  test "getblockcount" do
    block_count = Monerox.Daemon.getblockcount()
    assert main_data_correct(block_count)
    assert count_data_correct(block_count[:result])
  end

  test "getlastblockheader" do
    block_header = Monerox.Daemon.getlastblockheader()
    assert main_data_correct(block_header)
    assert block_header_correct(block_header[:result])
  end

  test "getblockheaderbyhash" do
    block_header = Monerox.Daemon.getblockheaderbyhash("hash-1111")
    assert main_data_correct(block_header)
    assert block_header_correct(block_header[:result])
  end

  test "getblockheaderbyheight" do
    block_header = Monerox.Daemon.getblockheaderbyheight(1234)
    assert main_data_correct(block_header)
    assert block_header_correct(block_header[:result])
  end

  test "getblock" do
    block_by_hash = Monerox.Daemon.getblock(%{hash: "hash-1111"})
    assert main_data_correct(block_by_hash)
    assert correct_block(block_by_hash[:result])

    block_by_heigh = Monerox.Daemon.getblock(%{height: 1234})
    assert main_data_correct(block_by_heigh)
    assert correct_block(block_by_heigh[:result])
  end

  test "getblocktemplate" do
    template = Monerox.Daemon.getblocktemplate("my-wallet-address", 60)
    assert main_data_correct(template)
    assert template_correct(template[:result])
  end

  test "get_info" do
    info = Monerox.Daemon.get_info()
    assert main_data_correct(info)
    assert info_corret(info[:result])
  end

  def count_data_correct(%{"count" => _, "status" => "OK"}), do: true
  def count_data_correct(_), do: false

  defp main_data_correct(%{id: "0", jsonrpc: "2.0", result: _}), do: true
  defp main_data_correct(_), do: false

  defp block_header_correct(%{block_header:
                              %Monerox.Daemon.BlockHeader{
                               block_size: _,
                               depth: _,
                               difficulty: _,
                               hash: _,
                               height: 1234,
                               major_version: _,
                               minor_version: _,
                               nonce: _,
                               num_txes: 2,
                               orphan_status: _,
                               prev_hash: _,
                               reward: _,
                               timestamp: %DateTime{}
                              },
                             status: "OK"}), do: true
  defp block_header_correct(_), do: false

  defp correct_block(%Monerox.Daemon.Block{
                      blob: _,
                      block_header: %Monerox.Daemon.BlockHeader{
                       block_size: _,
                       depth: _,
                       difficulty: _,
                       hash: _,
                       height: 1234,
                       major_version: _,
                       minor_version: _,
                       nonce: _,
                       num_txes: 2,
                       orphan_status: _,
                       prev_hash: _,
                       reward: _,
                       timestamp: %DateTime{}
                      },
                      json: _,
                      status: "OK",
                      tx_hashes: _
                    }), do: true
  defp correct_block(_), do: false

  defp template_correct(%Monerox.Daemon.BlockTemplate{
                          blocktemplate_blob: _,
                          difficulty: _,
                          height: _,
                          prev_hash: _,
                          reserved_offset: _}), do: true
  defp template_correct(_), do: false

  defp info_corret(%Monerox.Daemon.Info{
                    alt_blocks_count: _,
                    block_size_limit: _,
                    cumulative_difficulty: _,
                    difficulty: _,
                    grey_peerlist_size: _,
                    height: _,
                    incoming_connections_count: _,
                    outgoing_connections_count: _,
                    start_time: _,
                    status: _,
                    target: _,
                    target_height: _,
                    testnet: _,
                    top_block_hash: _,
                    tx_count: _,
                    tx_pool_size: _,
                    white_peerlist_size: _}), do: true
  defp info_corret(_), do: false

end
