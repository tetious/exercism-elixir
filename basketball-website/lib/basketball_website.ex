defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    path
    |> String.split(".")
    |> do_extract_from_path(data)
  end

  defp do_extract_from_path([key], data), do: data[key]
  defp do_extract_from_path([key | tail], data), do: do_extract_from_path(tail, data[key])

  def get_in_path(data, path), do: get_in(data, String.split(path, "."))
end
