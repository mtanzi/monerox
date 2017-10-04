defmodule Monerox.Daemon.RPC do

  use HTTPoison.Base

  def call(method, params \\ nil) do
    case post(daemon_path(), new_params(method, params), headers()) do
      {:ok, response} ->
        response
        |> do_response

      {:error, %HTTPoison.Error{reason: message}} ->
        {:error, message}
    end
  end

  def headers() do
    %{"Content-Type" => "application/json"}
  end

  def daemon_path() do
    "http://#{Application.get_env(:monerox, :daemon_rpc)[:host]}:#{Application.get_env(:monerox, :daemon_rpc)[:port]}/json_rpc"
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
