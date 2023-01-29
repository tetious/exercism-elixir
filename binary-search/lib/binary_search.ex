defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search({}, _key), do: :not_found
  def search(numbers, key), do: search(numbers, key, 0, tuple_size(numbers) - 1)

  defp search(numbers, key, l, r) do
    mid_i = round((r - l) / 2) + l
    mid = elem(numbers, mid_i)

    cond do
      mid == key -> {:ok, mid_i}
      mid != key && l == r -> :not_found
      key > mid -> search(numbers, key, mid_i + 1, r)
      key < mid -> search(numbers, key, l, mid_i - 1)
    end
  end
end
