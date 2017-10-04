defmodule Monerox.Daemon.Info do

defstruct alt_blocks_count: nil,
          block_size_limit: nil,
          cumulative_difficulty: nil,
          difficulty: nil,
          grey_peerlist_size: nil,
          height: nil,
          incoming_connections_count: nil,
          outgoing_connections_count: nil,
          start_time: nil,
          status: nil,
          target: nil,
          target_height: nil,
          testnet: nil,
          top_block_hash: nil,
          tx_count: nil,
          tx_pool_size: nil,
          white_peerlist_size: nil

  alias Monerox.Util

  @daemon_rpc Application.get_env(:monerox, :daemon_rpc)[:adapter]

  def get() do
    @daemon_rpc.call("get_info")
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

  def parse_result(%{"result" => result}) do

    struct(__MODULE__, (result |> Util.key_to_atom))
  end
  def parse_result(result), do: result
end
