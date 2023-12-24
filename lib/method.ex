defmodule Dummy.Method do
  @moduledoc """
  Handles replacing methods
  """
  defp expect(module, function_name, function) do
    :meck.expect(module, String.to_atom(function_name), function)
  end

  defp replace_arity(module, method, arity) do
    result = "#{method}/#{arity}"

    cond do
      arity == "0" ->
        expect(module, method, fn -> result end)

      arity == "1" ->
        expect(module, method, fn _x -> result end)

      arity == "2" ->
        expect(module, method, fn _x, _y -> result end)

      arity == "3" ->
        expect(module, method, fn _x, _y, _z -> result end)

      arity == "4" ->
        expect(module, method, fn _x, _y, _z, _w -> result end)

      arity == "5" ->
        expect(module, method, fn _x, _y, _z, _w, _k -> result end)
    end
  end

  defp replace_arity(module, method, arity, value) do
    cond do
      arity == "0" ->
        expect(module, method, fn -> value end)

      arity == "1" ->
        expect(module, method, fn _x -> value end)

      arity == "2" ->
        expect(module, method, fn _x, _y -> value end)

      arity == "3" ->
        expect(module, method, fn _x, _y, _z -> value end)

      arity == "4" ->
        expect(module, method, fn _x, _y, _z, _w -> value end)

      arity == "5" ->
        expect(module, method, fn _x, _y, _z, _w, _k -> value end)
    end
  end

  def replace(module, method) when is_binary(method) do
    shards = String.split(method, "/")

    if Enum.count(shards) == 2 do
      replace_arity(module, Enum.at(shards, 0), Enum.at(shards, 1))
    else
      expect(module, method, fn _ -> "#{method}/1" end)
    end
  end

  def replace(module, {function, replacement}) when is_function(replacement) do
    expect(module, function, replacement)
  end

  @doc """
  Replaces a method with a mock, according to how the mock was defined:
  "function", "function/N", {"function", value}, {"function/N", value}
  or {"function", fn}

  "function/<arity>" replaces a function with one that returns "function/<arity>".

  "function" is a shorthand for "function/1"

  {"function", value} replaces the function with an anonymous, single-argument
  function that returns 'value'

  {"function", fn a, b, .. -> body end} replaces the original function with
  the given one.
  """
  def replace(module, {function, value}) do
    shards = String.split(function, "/")

    if Enum.count(shards) == 2 do
      replace_arity(module, Enum.at(shards, 0), Enum.at(shards, 1), value)
    else
      expect(module, function, fn _x -> value end)
    end
  end
end
