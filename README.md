# Dummy

[![Hex.pm](https://img.shields.io/hexpm/v/dummy.svg?style=for-the-badge)](https://hex.pm/packages/dummy)
[![Travis (.com)](https://img.shields.io/travis/com/strangemachines/dummy.svg?style=for-the-badge)](https://travis-ci.com/strangemachines/dummy)
[![Hexdocs](https://img.shields.io/badge/docs-hexdocs-blueviolet.svg?style=for-the-badge)](https://hexdocs.pm/dummy)

Elixir mocking that makes sense. Dummy relies on meck and exposes a simple way
to mock methods, thanks to a couple of assumptions:

- passthrough is enabled
- mocked methods return their arguments
- it's easy to specify replacements


## Installing

```elixir
    {:dummy, "~> 1.3", only: :test}
```

## Usage


```elixir
use ExUnit.Case
import Dummy

alias MyApp.Module


test "my test" do
    dummy OtherModule, ["method"] do
        Module.call_to_other_module("arg1")
        assert called(OtherModule.method("arg1"))
    end
end
```

### Arities

```elixir
test "my test" do
    dummy OtherModule, ["method/2"] do
        Module.call_to_other_module("arg1", "arg2")
        assert called(OtherModule.method("arg1", "arg2"))
    end
end
```

### Specifying a return value

```elixir
test "my test" do
    dummy OtherModule, [{"method", "value"}] do
        assert OtherModule.method("anything") == "value"
    end
end
```

### Specifying a return value and an arity

```elixir
test "my test" do
    dummy OtherModule, [{"method/2", "value"}] do
        assert OtherModule.method(1, 2) == "value"
    end
end
```

### Specifying a replacement function

```elixir
test "my test" do
    dummy OtherModule, [{"method", fn _x -> %{key: => "value"} end}] do
        assert OtherModule.method("anything") == %{key: => "value"}
    end
end
```

### Multiple replacements

```elixir
test "my test" do
    dummy OtherModule, ["method", "other_method"] do
        Module.call_to_other_module("arg1")
        assert called(OtherModule.method("arg1"))
        assert called(OtherModule.other_method("other_arg"))
    end
end
```

### Disabling passthrough

```elixir
test "my test" do
    dummy OtherModule, ["method"], passthrough: false do
        Module.call_to_other_module("arg1")
        assert called(OtherModule.method("arg1"))
    end
end
```
