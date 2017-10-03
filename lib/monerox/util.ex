defmodule Monerox.Util do

  def demon_rpc(method, params \\ nil) do
    {:ok, response} = HTTPoison.post deamon_path, new_params(method, params), [{"Content-Type", "application/json"}]

    response
    |> do_response
  end

  def deamon_path do
    url = "http://#{Application.get_env(:monerox, :deamon_rpc)[:host]}:#{Application.get_env(:monerox, :deamon_rpc)[:port]}/json_rpc"
  end

  def new_params(method, params) do
    %{jsonrpc: "2.0", id: "0"}
    |> do_method(method)
    |> do_params(params)
    |> Poison.encode!
  end

  def do_method(data, method) do
    data |> Map.merge(%{method: method})
  end

  def do_params(data, params) when is_map(params) do
    data |> Map.merge(%{params: params})
  end
  def do_params(data, _), do: data

  def do_response(%{body: body, status_code: 200}) do
    body
    |> Poison.decode!
  end
  def do_response(%{body: body, status_code: _}) do
    body
  end
end
