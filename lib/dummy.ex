defmodule Dummy do
  @moduledoc """
  Documentation for Dummy.
  """
  alias Dummy.Method

  def apply_options(module, options) do
    if options[:passthrough] == false do
      :meck.new(module)
    else
      :meck.new(module, [:passthrough])
    end
  end

  defmacro called({{:., _, [module, f]}, _, args}) do
    quote do
      :meck.called(unquote(module), unquote(f), unquote(args))
    end
  end

  @doc """
  Mocks methods of a single module. Mocked methods return their
  first argument by default and non-mocked methods are passed through.
  """
  defmacro dummy(module_name, methods_list, options \\ [], do: test) do
    quote do
      module = unquote(module_name)
      methods = unquote(methods_list)
      apply_options(module, unquote(options))

      for method <- methods, do: Method.replace(module, method)

      try do
        unquote(test)
      after
        :meck.unload(module)
      end
    end
  end
end
