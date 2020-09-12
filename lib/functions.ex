defmodule Dummy.Functions do
  @doc """
  Provides functions that are hard to find/mock in the standard library.
  Tests can instead mock these.
  """
  def five(_a, _b, _c, _d, _e), do: :five
end
