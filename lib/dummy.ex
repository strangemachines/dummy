defmodule Dummy do
  @moduledoc """
  Documentation for Dummy.
  """


  @doc """
  Mocks methods of a single module. By defualt mocked methods return their first argument by default and non-mocked methods are passed through.
  """
  defmacro dummy(module, methods, do: test) do
    quote do
      :meck.new(unquote(module), [:passthrough])

      for method <- unquote(methods),
          do: :meck.expect(unquote(module), String.to_atom(method), fn x -> x end)

      unquote(test)
      :meck.unload(unquote(module))
    end
  end
end
