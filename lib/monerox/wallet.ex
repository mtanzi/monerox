defmodule Monerox.Wallet do
  alias Monerox.Util

  @wallet_rpc Application.get_env(:monerox, :wallet_rpc)[:adapter]

  def getaddress() do
    @wallet_rpc.call("getaddress")
    |> Util.key_to_atom
  end

end
