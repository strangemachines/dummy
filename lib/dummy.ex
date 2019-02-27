defmodule Dummy do
  @moduledoc """
  Documentation for Dummy.
  """

  defp apply_options(module, options) do
    if options[:passthrough] == false do
      :meck.new(module)
    else
      :meck.new(module, [:passthrough])
    end
  end

  @doc """
  Mocks methods of a single module. By defualt mocked methods return their first argument by default and non-mocked methods are passed through.
  """
  defmacro dummy(module_name, methods_list, options \\ [], do: test) do
    quote do
      module = unquote(module_name)
      methods = unquote(methods_list)
      apply_options(module, unquote(options))

      for method <- methods,
          do: :meck.expect(module, String.to_atom(method), fn x -> x end)

      unquote(test)
      :meck.unload(module)
    end
  end
end
