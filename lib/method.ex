defmodule Dummy.Method do
  @moduledoc """
  Handles replacing methods
  """
  defp expect(module, function_name, function) do
    :meck.expect(module, String.to_atom(function_name), function)
  end

  defp from_tuple(module, method) do
    function_name = elem(method, 0)
    replacement = elem(method, 1)

    if is_function(elem(method, 1)) do
      expect(module, function_name, replacement)
    else
      expect(module, function_name, fn _x -> replacement end)
    end
  end

  defp from_string(module, method) do
    shards = String.split(method, "/")

    if Enum.count(shards) == 2 do
      expect(module, Enum.at(shards, 0), fn x, y -> [x, y] end)
    else
      expect(module, method, fn x -> x end)
    end
  end

  @doc """
  Replaces a method with a mock, according to how the mock was defined:
  either with "function" or {"function", value} or {"function", fn}
  """
  def replace(module, method) do
    if is_tuple(method) do
      from_tuple(module, method)
    else
      from_string(module, method)
    end
  end
end
