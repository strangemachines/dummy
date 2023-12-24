defmodule DummyTest.Method do
  use ExUnit.Case
  alias Dummy.Method

  test "replacing a method" do
    Method.replace(File, "read")
    assert File.read("hello") == "hello"
  end

  test "replacing a method with an arity of 0" do
    Method.replace(Time, "utc_now/0")
    assert Time.utc_now() == "utc_now"
  end

  test "replacing a method with an arity of 2" do
    Method.replace(File, "open/2")
    assert File.open("hello", "world") == ["hello", "world"]
  end

  test "replacing a method with a specified arity of 3" do
    Method.replace(File, "open/3")
    assert File.open("hello", "world", "!") == ["hello", "world", "!"]
  end

  test "replacing a function with an arity of 4" do
    Method.replace(String, "replace/4")
    assert String.replace(1, 2, 3, 4) == [1, 2, 3, 4]
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
