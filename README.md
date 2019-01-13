# Dummy

Elixir mocking library that actually works.

(some examples)
```elixir
test "my test" do
    # Module, method, return value (or replacement function)
    # the default return value is the first argument (or maybe the method name)
    dummy.patch(OtherModule, :method, :nil)
    dummy.many(Module, [:method1])
    result = Module.method3("args")
    assert_called(OtherModule.method("args"))
    assert_called(Module.method1("args"))
    assert result == "expected"
    # In theory ExUnit.on_exit means dummy.reset might not be necessary
    dummy.reset()
end
```

(with a macro, 6 lines)
```elixir
test "my test" do
    dummy Module, [method1, method2] do
        result = Module.method3("args")
        assert_called(Module.method1("args"))
        assert_called(Module.method2("args"))
        assert result == "expected"
    end
end
```

(without, 5 lines)
```elixir
test "my test" do
    dummy.many(Module, [method1, method2])
    result = Module.method3("args")
    assert_called(Module.method1("args"))
    assert_called(Module.method2("args"))
    assert result == "expected"
end
```

In mock this would be 8 lines:

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

which means in case you're testing a function that calls others in the same module,
you don't have to write dummy function when running with passthrough.

It's also easier to apply multiple mocks over different methods

(You do have to use the fully qualified name in the function call though.)

## But mocks are not for Elixir

I know what you're thinking: Jose said that mocking is evil, however he
forgot some bits in his piece. What he calls for is called Detroit-style TDD,
while mocks are widely used in London-style TDD. They have been discussed for
decades, and I find incredibly annoying that the entire Elixir community accepted
that as the only true way of testing, because "it's the Elixir way".

The benefits of Detroit-style TDD is that you write less tests and don't have
to worry about mocks. The con is that you are mixing unit and integration tests,
and that negates most of the benefits of TDD.

In London-style TDD each test is isolated with mocks. That means you get
full TDD benefits. The con is that you must also write integration tests and
maintain both.
