defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    %{3 => "i", 5 => "a", 7 => "o"}
    |> Enum.reduce("", &(&2 <> convert(number, &1)))
    |> resolve(number)
  end

  defp resolve("", number), do: to_string(number)
  defp resolve(converted, _number), do: converted

  defp convert(number, {factor, letter}) when rem(number, factor) == 0, do: "Pl#{letter}ng"
  defp convert(_number, _), do: ""
end
