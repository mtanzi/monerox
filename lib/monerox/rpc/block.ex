defmodule Monerox.RPC.Block do
  defstruct blob: nil,
            block_header: nil,
            json: nil,
            status: nil,
            tx_hashes: nil

  def get(height) do
    Monerox.Util.demon_rpc("getblock", %{height: height})
    |> parse_response
  end

  def parse_response(%{"id" => "0",
                       "jsonrpc" => "2.0",
                       "result" => _} = result) do
    result
    |> key_to_atom
    |> Map.put(:result, parse_result(result))
  end
  def parse_response(%{"error" => %{"message" => message}}) do
    {:error, message}
  end

  def parse_result(%{"result" => %{"block_header"=> block_header} = block}) do
    new_block =
      block
      |> key_to_atom
      |> Map.put(:block_header, parse_block_header(block_header))

    struct(__MODULE__, new_block)
  end
  def parse_result(result), do: result

  def parse_block_header(block_header) do
    struct(Monerox.RPC.BlockHeader, (block_header |> key_to_atom))
  end

  def key_to_atom(data) do
    data
    |> Enum.reduce(%{},
      fn ({key, val}, acc) ->
        Map.put(acc, String.to_atom(key), val)
      end)
  end
end
