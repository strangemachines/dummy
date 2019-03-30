defmodule DummyTest.Method do
  use ExUnit.Case
  alias Dummy.Method

  test "replacing a method" do
    Method.replace(File, "read")
    assert File.read("hello") == "hello"
  end

  test "replacing a method with a specified value" do
    Method.replace(File, {"read", "world"})
    assert File.read("hello") == "world"
  end

  test "replacing a method with a specified function" do
    Method.replace(File, {"read", fn _a -> "hello world" end})
    assert File.read("hello") == "hello world"
  end
end
