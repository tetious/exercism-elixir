defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(1), do: 2

  def nth(count) when count > 0 do
    do_nth(1, count, 1)
  end

  defp do_nth(count, count, n), do: n - 2

  defp do_nth(found, count, n) do
    if(prime?(n), do: found + 1, else: found)
    |> do_nth(count, n + 2)
  end

  defp prime?(n) do
    max = :math.sqrt(n) |> ceil()
    !(2..max |> Enum.find(false, &(rem(n, &1) == 0)))
  end
end
