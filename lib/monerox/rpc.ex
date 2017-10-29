defmodule Monerox.RPC do
  @moduledoc false

  defmacro __using__(opts) do
    quote do
      @env_vars unquote(opts)
      @on_definition {unquote(__MODULE__), :__on_definition__}
      @before_compile {unquote(__MODULE__), :__before_compile__}

      use HTTPoison.Base

      @headers [{"Content-Type", "application/json"}]

      @params %{jsonrpc: "2.0", id: "0"}

      def call(params \\ nil) do
        do_post(wallet_path(), params, @headers)
      end

      def do_post(path, params, headers) do
        case post(path, params, headers) do
          {:ok, response} ->
            case response.status_code do
              200 ->
                response
                |> do_response

              401 ->
                case create_digest_headers(response.headers) do
                  {:ok, authorization} ->
                    do_post(path, params, authorization)

                  {:error, message} ->
                    {:error, message}
                end

              _ ->
                {:error, "Status code (#{response.status_code}) not supported"}
            end

          {:error, %HTTPoison.Error{reason: message}} ->
            {:error, message}
        end
      end

      def create_digest_headers(headers) do
        try do
          authorization =
            Httpdigest.create_header(headers, @username, @password, "POST", "/json_rpc")

          {:ok, authorization}
        rescue
          ArgumentError -> {:error, "Authorization failed"}
        end
      end

      def do_response(%{body: body, status_code: 200}) do
        body |> Poison.decode!()
      end

      def do_response(%{body: body, status_code: _}), do: body
    end
  end

  def __on_definition__(env, _kind, _name, _args, _guards, _body) do
    Module.get_attribute(env.module, :env_vars)
    |> Enum.each(fn var ->
         set_vars(var, env.module)
       end)
  end

  def set_vars({:host, host}, module), do: Module.put_attribute(module, :host, host)
  def set_vars({:port, port}, module), do: Module.put_attribute(module, :port, port)

  def set_vars({:username, username}, module) when not is_nil(username) do
    Module.put_attribute(module, :username, username)
  end

  def set_vars({:username, _username}, module), do: Module.put_attribute(module, :username, nil)

  def set_vars({:password, password}, module) when not is_nil(password) do
    Module.put_attribute(module, :password, password)
  end

  def set_vars({:password, _password}, module), do: Module.put_attribute(module, :password, nil)
  def set_vars(_var, _module), do: nil

  defmacro __before_compile__(_env) do
    quote do
      def wallet_path, do: "http://#{@host}:#{@port}/json_rpc"
    end
  end
end
