defmodule BellaTest do
  use ExUnit.Case
  doctest Bella

  test "greets the world" do
    assert Bella.hello() == :world
  end
end
