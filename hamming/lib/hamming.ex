defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(s1, s2) when length(s1) != length(s2),
    do: {:error, "strands must be of equal length"}

  def hamming_distance(s, s), do: {:ok, 0}
  def hamming_distance(s1, s2), do: {:ok, do_hamming_distance(s1, s2)}

  defp do_hamming_distance(s1, s2),
    do: Enum.zip(s1, s2) |> Enum.count(fn {n1, n2} -> n1 != n2 end)
end
