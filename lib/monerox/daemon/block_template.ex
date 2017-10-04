defmodule Monerox.Daemon.BlockTemplate do
  defstruct blocktemplate_blob: nil,
            difficulty: nil,
            height: nil,
            prev_hash: nil,
            reserved_offset: nil

  alias Monerox.Util

  @daemon_rpc Application.get_env(:monerox, :daemon_rpc)[:adapter]

  def get(wallet_address, reserve_size) do
    @daemon_rpc.call("getblocktemplate", %{wallet_address: wallet_address, reserve_size: reserve_size})
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
    do: parse_get_response({:error, message})
  def parse_response(error), do: error

  def parse_result(%{"result" => result}) do

    struct(__MODULE__, (result |> Util.key_to_atom))
  end
  def parse_result(result), do: result
end
