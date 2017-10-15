defmodule Monerox.Wallet.Info do
  alias Monerox.Util

  @daemon_rpc Application.get_env(:monerox, :wallet_rpc)[:adapter]

  def balance() do
    @daemon_rpc.call("getbalance")
    |> parse_response
  end

  def address() do
    @daemon_rpc.call("getaddress")
    |> parse_response
  end

  def height() do
    @daemon_rpc.call("getheight")
    |> parse_response
  end

  def parse_response(%{"id" => "0",
                       "jsonrpc" => "2.0",
                       "result" => %{} = result
                      } = response) do
    result_atom =
      result
      |> Util.key_to_atom

    response
    |> Util.key_to_atom
    |> Map.put(:result, result_atom)
  end
end
