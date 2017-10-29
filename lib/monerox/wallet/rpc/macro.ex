defmodule Monerox.Wallet.RPC.Macro do
  @moduledoc false

  alias Monerox.Wallet.RPC.{Server, Behaviour}

  defmacro __using__(_) do
    quote location: :keep do
      @behaviour Behaviour
      @type error :: Behaviour.error()

      use Monerox.RPC, Application.get_env(:monerox, :wallet_rpc)

      @spec getbalance() :: {:ok, binary()} | error
      def getbalance() do
        "getbalance" |> request([])
      end

      @spec getaddress() :: {:ok, binary()} | error
      def getaddress() do
        "getaddress" |> request([])
      end

      @spec getheight() :: {:ok, binary()} | error
      def getheight() do
        "getheight" |> request([])
      end

      @spec add_request_info(binary, [binary] | [map]) :: map
      defp add_request_info(method_name, params \\ []) do
        %{}
        |> Map.put("method", method_name)
        |> Map.put("jsonrpc", "2.0")
        |> Map.put("id", "0")
        |> Map.put("params", params)
      end

      def request(name, params) do
        name
        |> add_request_info(params)
        |> server_request
      end

      defp server_request(params) do
        GenServer.call(__MODULE__, {:wallet_request, params})
      end

      def start_link do
        Server.start_link(__MODULE__)
      end

      def reset_id do
        GenServer.cast(__MODULE__, :wallet_reset_id)
      end

      def single_request(params) do
        {:error, :not_implemented}
      end

      defoverridable single_request: 1
    end
  end
end
