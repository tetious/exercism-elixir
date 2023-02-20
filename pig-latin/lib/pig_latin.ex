defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase |> String.split(" ") |> Enum.map(&do_translate/1) |> Enum.join(" ")
  end

  defp do_translate(word) do
    case String.split(word, ~R/([aeiou]|(?<=.{1})y|[xy][^aeiou]|qu)/, include_captures: true) do
      [consonant, "qu" | rest] -> (rest |> Enum.join()) <> consonant <> "quay"
      [consonant | rest] -> (rest |> Enum.join()) <> consonant <> "ay"
    end
  end
end
