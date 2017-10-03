defmodule Monerox.RPC.BlockTemplate do
  defstruct blocktemplate_blob: nil,
            difficulty: nil,
            height: nil,
            prev_hash: nil,
            reserved_offset: nil

  def get(wallet_address, reserve_size) do
    Monerox.Util.demon_rpc("getblocktemplate", %{wallet_address: wallet_address, reserve_size: reserve_size})
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

  def parse_result(%{"result" => result}) do

    struct(__MODULE__, (result |> key_to_atom))
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
