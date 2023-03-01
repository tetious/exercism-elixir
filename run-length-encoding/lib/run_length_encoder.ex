defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.codepoints()
    |> Enum.reduce({"", 1, ""}, fn
      last, {last, count, a} -> {last, count + 1, a}
      current, set -> {current, 1, append_value(set)}
    end)
    |> append_value()
  end

  defp append_value({last, count, a}), do: a <> if(count > 1, do: "#{count}#{last}", else: last)

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.scan(~R/(\d*)(\D)/, string)
    |> Enum.reduce("", fn
      [_, "", l], a -> a <> l
      [_, count, l], a -> a <> String.duplicate(l, String.to_integer(count))
    end)
  end
end
