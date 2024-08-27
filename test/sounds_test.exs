defmodule SoundsTest do
  use ExUnit.Case
  doctest Sounds

  test "greets the world" do
    assert Sounds.hello() == :world
  end
end
