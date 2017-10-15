defmodule Monerox.Daemon.BlockHeader do
  defstruct block_size: nil,
            depth: nil,
            difficulty: nil,
            hash: nil,
            height: nil,
            major_version: nil,
            minor_version: nil,
            nonce: nil,
            num_txes: nil,
            orphan_status: nil,
            prev_hash: nil,
            reward: nil,
            timestamp: nil

  alias Monerox.Util

  @daemon_rpc Application.get_env(:monerox, :daemon_rpc)[:adapter]

  def get_last() do
    @daemon_rpc.call("getlastblockheader")
    |> parse_response
  end

  def get_by_height(height) do
    @daemon_rpc.call("getblockheaderbyheight", %{height: height})
    |> parse_response
  end

  def get_by_hash(hash) do
    @daemon_rpc.call("getblockheaderbyhash", %{hash: hash})
    |> parse_response
  end

  def parse_response(%{"id" => "0",
                       "jsonrpc" => "2.0",
                       "result" => _} = result) do
    result
    |> Util.key_to_atom
    |> Map.put(:result, parse_result(result))
  end
  def parse_response(%{"error" => %{"message" => message}}),
    do: parse_response({:error, message})
  def parse_response(error), do: error

  def parse_result(%{"result" =>
                     %{"block_header" => block_header,
                       "status" => "OK"} = data}) do

    block_header_formatted =
      block_header
      |> Util.key_to_atom
      |> Util.convert_date

    data
    |> Util.key_to_atom
    |> Map.put(:block_header, struct(__MODULE__, block_header_formatted))
  end
  def parse_result(result), do: result
end
