defmodule PalindromeProducts do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1)

  def generate(max_factor, min_factor) when min_factor <= max_factor do
    for i <- min_factor..max_factor,
        j <- i..max_factor,
        product = i * j,
        palindrome?(product),
        reduce: %{} do
      acc ->
        Map.update(acc, product, [[i, j]], &[[i, j] | &1])
    end
  end

  def generate(_, _), do: raise(ArgumentError, "min must be less than max")

  defp palindrome?(num) do
    digits = num |> Integer.digits()
    digits == Enum.reverse(digits)
  end
end
