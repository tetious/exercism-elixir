defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    input = String.trim(input)
    cond do
      question?(input) and yelling?(input) -> "Calm down, I know what I'm doing!"
      question?(input) -> "Sure."
      yelling?(input) -> "Whoa, chill out!"
      input == "" -> "Fine. Be that way!"
      true -> "Whatever."
    end
  end

  defp yelling?(input), do: String.upcase(input) == input && String.downcase(input) != input
  defp question?(input), do: String.ends_with?(input, "?")
end
