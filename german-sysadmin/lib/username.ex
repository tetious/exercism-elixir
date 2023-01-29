defmodule Username do
  def sanitize(username) do
    do_sanitize(username |> Enum.reverse(), [])
  end

  defp do_sanitize([], a), do: a

  @german %{?ä => 'ae', ?ö => 'oe', ?ü => 'ue', ?ß => 'ss'}

  defp do_sanitize([hd | tl], a) do
    case hd do
      hd when hd in 97..122 ->
        do_sanitize(tl, [hd | a])

      ?_ ->
        do_sanitize(tl, [hd | a])

      hd when is_map_key(@german, hd) ->
        do_sanitize(tl, @german[hd] ++ a)

      _ ->
        do_sanitize(tl, a)
    end
  end
end
