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

  test "the dummy macro with options" do
    dummy IO, ["puts"], passthrough: false do
      assert IO.puts("hello") == "hello"

      try do
        IO.chardata_to_string([0x0061]) == "a"
      rescue
        _error in UndefinedFunctionError -> nil
      end
    end
  end
end
