defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist()
    |> Enum.map(&rotate_letter(&1, shift))
    |> List.to_string()
  end

  defp rotate_letter(letter, shift) when letter in ?a..?z do
    rem(letter - ?a + shift, 26) + ?a
  end

  defp rotate_letter(letter, shift) when letter in ?A..?Z do
    rem(letter - ?A + shift, 26) + ?A
  end

  defp rotate_letter(letter, _shift), do: letter
end
