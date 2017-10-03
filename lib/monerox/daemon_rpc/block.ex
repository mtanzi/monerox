defmodule Monerox.DaemonRPC.Block do
  defstruct blob: nil,
            block_header: nil,
            json: nil,
            status: nil,
            tx_hashes: nil

  alias Monerox.Util

  def count() do
    Monerox.RPC.demon_rpc("getblockcount")
    |> parse_count_response
  end

  def get(%{height: height} = params), do: do_get(params)
  def get(%{hash: hash} = params), do: do_get(params)
  def get(_), do: {:error, "wrong params passed"}

  def do_get(params) do
    Monerox.RPC.demon_rpc("getblock", params)
    |> parse_get_response
  end

  def parse_count_response(%{"id" => "0",
                             "jsonrpc" => "2.0",
                             "result" => _} = result) do
    result
    |> Util.key_to_atom
  end
  def parse_count_response(%{"error" => %{"message" => message}}),
    do: parse_get_response({:error, message})
  def parse_count_response(error), do: error

  def parse_get_response(%{"id" => "0",
                           "jsonrpc" => "2.0",
                           "result" => _} = result) do
    result
    |> Util.key_to_atom
    |> Map.put(:result, parse_result(result))
  end
  def parse_get_response(%{"error" => %{"message" => message}}),
    do: parse_get_response({:error, message})
  def parse_get_response(error), do: error

  def parse_result(%{"result" => %{"block_header"=> block_header} = block}) do
    new_block =
      block
      |> Util.key_to_atom
      |> Map.put(:block_header, parse_block_header(block_header))

    struct(__MODULE__, new_block)
  end
  def parse_result(result), do: result

  def parse_block_header(block_header) do
    struct(Monerox.DaemonRPC.BlockHeader, (block_header |> Util.key_to_atom))
  end
end
