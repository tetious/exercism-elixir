defmodule RomanNumerals do
  @numerals [{"I", "V"}, {"X", "L"}, {"C", "D"}, {"M", nil}]

  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    number |> Integer.digits() |> do_numeral("")
  end

  defp do_numeral([], result), do: result

  defp do_numeral([9 | tail], result) do
    [{one, _}, {ten, _}] = Enum.slice(@numerals, length(tail), 2)
    do_numeral(tail, result <> one <> ten)
  end

  defp do_numeral([digit | tail], result) do
    do_numeral(tail, result <> get_digit(digit, Enum.at(@numerals, length(tail))))
  end

  defp get_digit(0, {_one, _five}), do: ""
  defp get_digit(digit, {one, _five}) when digit < 4, do: String.duplicate(one, digit)
  defp get_digit(4, {one, five}), do: one <> five
  defp get_digit(digit, {one, five}) when digit < 9, do: five <> String.duplicate(one, digit - 5)
end
