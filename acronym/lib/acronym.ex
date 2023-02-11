defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.split(~R/[\s-_]/)
    |> Enum.map(&first_letter/1)
    |> Enum.join()
  end

  defp first_letter(""), do: ""
  defp first_letter(word), do: word |> String.first() |> String.upcase()
end
