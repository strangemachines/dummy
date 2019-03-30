defmodule Dummy.Method do
  @moduledoc """
  Handles replacing methods
  """

  defp from_tuple(module, method) do
    function_name = String.to_atom(elem(method, 0))

    if is_function(elem(method, 1)) do
      :meck.expect(module, function_name, elem(method, 1))
    else
      :meck.expect(module, function_name, fn _x -> elem(method, 1) end)
    end
  end

  defp from_string(module, method) do
    shards = String.split(method, "/")

    if Enum.count(shards) == 2 do
      :meck.expect(module, String.to_atom(Enum.at(shards, 0)), fn x, y -> [x, y] end)
    else
      :meck.expect(module, String.to_atom(method), fn x -> x end)
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
