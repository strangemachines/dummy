defmodule Dummy.Method do
  @moduledoc """
  Handles replacing methods
  """
  defp expect(module, function_name, function) do
    :meck.expect(module, String.to_atom(function_name), function)
  end

  @doc """
  Replaces a function with a value or a function.

  {"function", value} replaces the function with an anonymous, single-argument
  function that returns 'value'

  {"function", fn ... -> ... end} replaces the original function with the given
  one.
  """
  def replace_from_tuple(module, method) do
    function_name = elem(method, 0)
    replacement = elem(method, 1)

    if is_function(elem(method, 1)) do
      expect(module, function_name, replacement)
    else
      expect(module, function_name, fn _x -> replacement end)
    end
  end

  @doc """
  Replaces a function from a string like "function" or "function/<arity>".
  """
  def replace_from_string(module, method) do
    shards = String.split(method, "/")

    if Enum.count(shards) == 2 do
      method = Enum.at(shards, 0)
      arity = Enum.at(shards, 1)

      cond do
        arity == "0" ->
          expect(module, method, fn -> method end)

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

  @doc """
  Replaces a method with a mock, according to how the mock was defined:
  "function", "function/N" or {"function", value} or {"function", fn}
  """
  def replace(module, method) do
    if is_tuple(method) do
      replace_from_tuple(module, method)
    else
      replace_from_string(module, method)
    end
  end
end
