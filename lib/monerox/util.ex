defmodule Monerox.Util do
  @moduledoc false

  def key_to_atom(data) do
    data
    |> Enum.reduce(%{}, fn {key, val}, acc ->
         Map.put(acc, String.to_atom(key), val)
       end)
  end

  def convert_date(%{timestamp: timestamp} = data) do
    data
    |> Map.put(:timestamp, timestamp |> DateTime.from_unix!())
  end
end
