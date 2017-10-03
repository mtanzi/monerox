defmodule Monerox.Util do
  def key_to_atom(data) do
    data
    |> Enum.reduce(%{},
      fn ({key, val}, acc) ->
        Map.put(acc, String.to_atom(key), val)
      end)
  end
end
