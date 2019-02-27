# Dummy

Elixir mocking that makes sense. Dummy relies on meck and exposes a simpler way
to mock methods than mock, thanks to a couple of assumptions:

- passthrough is enabled
- mocked methods return their first argument


### Installing

```elixir
    {:dummy, "~> 1.0.0", only: :test}
```

### Usage

```elixir
test "my test" do
    dummy Module, [method1, method2] do
        result = Module.method3("args")
        called(Module.method1("args"))
        called(Module.method2("args"))
        assert result == "expected"
    end
end
```

In mock this would be a bit longer:

```elixir
test "my test" do
    with_mock Module, [:passthrough],
      method1: fn path -> path end,
      method2: fn yaml -> yaml end do
      result = Module.method3("args")
      assert_called(Module.method1("args"))
      assert_called(Module.method2("args"))
      assert result == "expected"
    end
end
```

You can disable passthrough:

```elixir
test "my test" do
    dummy Module, [method1], passthrough: false do
        # ...
    end
end
```

You can specify a return value:

```elixir
test "my test" do
    dummy Module, [{method1, "value"}] do
        assert Module.method1("anything") == "value"
    end
end
```

Or replacements:

```elixir
test "my test" do
    dummy Module, [{method1, fn _x, _y -> "value" end}] do
        assert Module.method1("anything", "works") == "value"
    end
end
```
