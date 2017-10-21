defmodule Monerox.Daemon.RPC.Macro do
  alias Monerox.Daemon.RPC.{Server, Behaviour}

  @moduledoc false

  defmacro __using__(_) do
    quote location: :keep do
      @behaviour Behaviour
      @type error :: Behaviour.error

      use Monerox.RPC, Application.get_env(:monerox, :daemon_rpc)

      @spec getblockcount() :: {:ok, binary()} | error
      def getblockcount() do
        "getblockcount" |> request([])
      end

      @spec getblocktemplate(binary(), integer()) :: {:ok, binary()} | error
      def getblocktemplate(wallet_address, reverse_size \\ 8) do
        "getblocktemplate" |> request(%{wallet_address: wallet_address,
                                        reverse_size: reverse_size})
      end

      @spec getlastblockheader() :: {:ok, binary()} | error
      def getlastblockheader() do
        "getlastblockheader" |> request([])
      end

      @spec getblockheaderbyhash(binary()) :: {:ok, binary()} | error
      def getblockheaderbyhash(hash) do
        "getblockheaderbyhash" |> request(%{hash: hash})
      end

      @spec getblockheaderbyheight(binary()) :: {:ok, boolean()} | error
      def getblockheaderbyheight(height) do
        "getblockheaderbyheight" |> request(%{height: height})
      end

      @spec getblock(map()) :: {:ok, binary()} | error
      def getblock(%{hash: hash}) do
        "getblock" |> request(%{hash: hash})
      end
      def getblock(%{height: height}) do
        "getblock" |> request(%{height: height})
      end

      @spec get_info() :: {:ok, map() | true} | error
      def get_info() do
        "get_info" |> request([])
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
        GenServer.call __MODULE__, {:request, params}
      end

      def start_link do
        Server.start_link(__MODULE__)
      end

      def reset_id do
        GenServer.cast __MODULE__, :reset_id
      end

      def single_request(params) do
        {:error, :not_implemented}
      end

      defoverridable [single_request: 1]
    end
  end

end
