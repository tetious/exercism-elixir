defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    base = normalize(base)
    sorted_base = Enum.sort(base)

    candidates
    |> Enum.filter(fn candidate ->
      candidate = normalize(candidate)
      base != candidate and sorted_base == Enum.sort(candidate)
    end)
  end

  defp normalize(word), do: word |> String.downcase() |> String.graphemes()
end
