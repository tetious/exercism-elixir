defmodule ETL do
  @doc """
  Transforms an old Scrabble score system to a new one.

  ## Examples

    iex> ETL.transform(%{1 => ["A", "E"], 2 => ["D", "G"]})
    %{"a" => 1, "d" => 2, "e" => 1, "g" => 2}
  """
  @spec transform(map) :: map
  def transform(input), do: input |> Enum.reduce(%{}, &convert_item/2)

  defp convert_item({score, letters}, result),
    do: Enum.reduce(letters, result, &Map.put(&2, String.downcase(&1), score))
end
