defmodule SocketCanDemoTest do
  use ExUnit.Case
  doctest SocketCanDemo

  test "greets the world" do
    assert SocketCanDemo.hello() == :world
  end
end
