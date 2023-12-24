defmodule DummyTest do
  use ExUnit.Case
  doctest Dummy
  import Dummy

  test "the dummy macro" do
    dummy IO, ["puts"] do
      assert IO.puts("hello") == "hello"
      assert IO.chardata_to_string([0x0061]) == "a"
    end
  end
end
