defmodule DummyTest.Method do
  use ExUnit.Case
  alias Dummy.Method

  test "replace/2 with a string" do
    Method.replace(File, "read")
    assert File.read("hello") == "hello"
  end

  test "replace/2 with function_name/0" do
    Method.replace(Time, "utc_now/0")
    assert Time.utc_now() == "utc_now"
  end

  test "replace/2 with function_name/1" do
    Method.replace(File, "read/1")
    assert File.read("hello") == "hello"
  end

  test "replace/2 with function_name/2" do
    Method.replace(File, "open/2")
    assert File.open("hello", "world") == ["hello", "world"]
  end

  test "replace/2 with function_name/3" do
    Method.replace(File, "open/3")
    assert File.open("hello", "world", "!") == ["hello", "world", "!"]
  end

  test "replace/2 with function_name/4" do
    Method.replace(String, "replace/4")
    assert String.replace(1, 2, 3, 4) == [1, 2, 3, 4]
  end

  test "replace/2 with a value" do
    Method.replace(File, {"read", "world"})
    assert File.read("hello") == "world"
  end

  test "replace/2 with function_name/0 and a value" do
    Method.replace(Time, {"utc_now/0", "now"})
    assert Time.utc_now() == "now"
  end

  test "replace/2 with function_name/1 and a value" do
    Method.replace(File, {"read/1", "read"})
    assert File.read("hello") == "read"
  end

  test "replace/2 with function_name/2 and a value" do
    Method.replace(File, {"open/2", "open"})
    assert File.open("hello", "world") == "open"
  end

  test "replace/2 with function_name/3 and a value" do
    Method.replace(File, {"open/3", "open"})
    assert File.open("hello", "world", "!") == "open"
  end

  test "replace/2 with function_name/4 and a value" do
    Method.replace(String, {"replace/4", "1234"})
    assert String.replace(1, 2, 3, 4) == "1234"
  end

  test "replace/2 with a function" do
    Method.replace(File, {"read", fn _a -> "hello world" end})
    assert File.read("hello") == "hello world"
  end
end
