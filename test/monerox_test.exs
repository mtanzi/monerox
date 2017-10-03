defmodule MoneroxTest do
  use ExUnit.Case
  doctest Monerox

  test "greets the world" do
    assert Monerox.hello() == :world
  end
end
