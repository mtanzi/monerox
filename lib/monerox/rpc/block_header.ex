defmodule Monerox.RPC.BlockHeader do
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

  def get_last() do
    Monerox.Util.demon_rpc("getlastblockheader")
    |> parse_response
  end

  def get_by_height(height) do
    Monerox.Util.demon_rpc("getblockheaderbyheight", %{height: height})
    |> parse_response
  end

  def get_by_hash(hash) do
    Monerox.Util.demon_rpc("getblockheaderbyhash", %{hash: hash})
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

  def parse_result(%{"result" =>
                     %{"block_header" => result,
                       "status" => "OK"} = block_header}) do
    block_header
    |> key_to_atom
    |> Map.put(:block_header, struct(__MODULE__, (result |> key_to_atom)))
  end
  def parse_result(result), do: result

  def key_to_atom(data) do
    data
    |> Enum.reduce(%{},
      fn ({key, val}, acc) ->
        Map.put(acc, String.to_atom(key), val)
      end)
  end
end
