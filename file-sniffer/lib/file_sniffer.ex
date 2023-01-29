defmodule FileSniffer do
  @ext_table %{
    "exe" => "application/octet-stream",
    "bmp" => "image/bmp",
    "png" => "image/png",
    "jpg" => "image/jpg",
    "gif" => "image/gif"
  }

  def type_from_extension(extension), do: Map.get(@ext_table, extension)

  def type_from_binary(file_binary) do
    @ext_table |> Map.get(decode_type(file_binary))
  end

  defp decode_type(file_binary) do
    case file_binary do
      <<0x7F, 0x45, 0x4C, 0x46, _::binary>> -> "exe"
      <<0x42, 0x4D, _::binary>> -> "bmp"
      <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::binary>> -> "png"
      <<0xFF, 0xD8, 0xFF, _::binary>> -> "jpg"
      <<0x47, 0x49, 0x46, _::binary>> -> "gif"
      _ -> nil
    end
  end

  def verify(file_binary, extension) do
    type = decode_type(file_binary)

    if type == extension do
      {:ok, @ext_table[type]}
    else
      {:error, "Warning, file format and file extension do not match."}
    end
  end
end
