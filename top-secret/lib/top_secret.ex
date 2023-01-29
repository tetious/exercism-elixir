defmodule TopSecret do
  def to_ast(string), do: Code.string_to_quoted!(string)

  def decode_secret_message_part({top, _, [func | _]} = ast, acc) when top in [:def, :defp] do
    {ast, [decode_func(func) | acc]}
  end

  def decode_secret_message_part(ast, acc), do: {ast, acc}

  defp decode_func({:when, _, [func | _]}), do: decode_func(func)

  defp decode_func(func) do
    case func do
      {_, _, []} -> ""
      {_, _, nil} -> ""
      {name, _, params} -> name |> to_string() |> String.sli(0, length(params))
    end
  end

  def decode_secret_message(string) do
    string
    |> to_ast()
    |> Macro.prewalk([], &decode_secret_message_part/2)
    |> elem(1)
    |> Enum.reduce(&<>/2)
  end
end
