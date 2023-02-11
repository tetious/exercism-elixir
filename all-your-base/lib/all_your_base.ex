defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_digits, _input_base, output_base) when output_base < 2,
    do: {:error, "output base must be >= 2"}

  def convert(_digits, input_base, _output_base) when input_base < 2,
    do: {:error, "input base must be >= 2"}

  def convert(digits, input_base, output_base) do
    if digits |> Enum.any?(&(&1 < 0 or &1 >= input_base)) do
      {:error, "all digits must be >= 0 and < input base"}
    else
      len = length(digits) - 1

      out =
        digits
        |> Stream.with_index()
        |> Enum.reduce(0, fn {d, i}, a -> a + d * input_base ** (len - i) end)
        |> to_output(output_base, [])

      {:ok, out}
    end
  end

  defp to_output(decimal, 10, _acc), do: decimal |> Integer.digits()
  defp to_output(0, _output_base, []), do: [0]
  defp to_output(0, _output_base, acc), do: acc

  defp to_output(decimal, output_base, acc),
    do: to_output(div(decimal, output_base), output_base, [rem(decimal, output_base) | acc])
end
