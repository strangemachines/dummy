defmodule Dummy.Method do
  @moduledoc """
  Handles replacing methods
  """
  defp expect(module, function_name, function) do
    :meck.expect(module, String.to_atom(function_name), function)
  end

  def replace(module, method) when is_binary(method) do
    shards = String.split(method, "/")

    if Enum.count(shards) == 2 do
      method = Enum.at(shards, 0)
      arity = Enum.at(shards, 1)

      cond do
        arity == "0" ->
          expect(module, method, fn -> method end)

        arity == "1" ->
          expect(module, method, fn x -> x end)

        arity == "2" ->
          expect(module, method, fn x, y -> [x, y] end)

        arity == "3" ->
          expect(module, method, fn x, y, z -> [x, y, z] end)

        arity == "4" ->
          expect(module, method, fn x, y, z, w -> [x, y, z, w] end)
      end
    else
      expect(module, method, fn x -> x end)
    end
  end

  def replace(module, {function, replacement}) when is_function(replacement) do
    expect(module, function, replacement)
  end

  @doc """
  Replaces a method with a mock, according to how the mock was defined:
  "function", "function/N" or {"function", value} or {"function", fn}

  "function/<arity>" replaces a function with one that returns its parameters.

  "function" is a shorthand for "function/1"

  {"function", value} replaces the function with an anonymous, single-argument
  function that returns 'value'

  {"function", fn a, b, .. -> body end} replaces the original function with
  the given one.
  """
  def replace(module, {function, value}) do
    expect(module, function, fn _x -> value end)
  end
end
