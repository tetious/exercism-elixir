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

  def hamming_distance(s1, s2), do: {:ok, hamming_distance(s1, s2, 0)}

  defp hamming_distance(s, s, dist), do: dist

  defp hamming_distance([p | tail1], [p | tail2], dist),
    do: hamming_distance(tail1, tail2, dist)

  defp hamming_distance([_ | tail1], [_ | tail2], dist),
    do: hamming_distance(tail1, tail2, dist + 1)
end
