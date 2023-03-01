defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.upcase()
    |> String.codepoints()
    |> Enum.reduce(0, fn l, score -> score_letter(l) + score end)
  end

  defp score_letter(letter) when letter in ~W(A E I O U L N R S T), do: 1
  defp score_letter(letter) when letter in ~W(D G), do: 2
  defp score_letter(letter) when letter in ~W(B C M P), do: 3
  defp score_letter(letter) when letter in ~W(F H V W Y), do: 4
  defp score_letter("K"), do: 5
  defp score_letter(letter) when letter in ~W(J X), do: 8
  defp score_letter(letter) when letter in ~W(Q Z), do: 10
  defp score_letter(_), do: 0
end
