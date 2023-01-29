defmodule LogParser do
  def valid_line?(line) do
    line |> String.match?(~r/^\[(DEBUG|INFO|WARNING|ERROR)\]/)
  end

  def split_line(line) do
    line |> String.split(~r/<([~|*|=|-])*>/)
  end

  def remove_artifacts(line) do
    line |> String.replace(~r/end-of-line(\d)+/i, "")
  end

  def tag_with_user_name(line) do
    if m = Regex.run(~r/User\s+(\S*)/, line) do
      [_, user] = m
      "[USER] #{user} #{line}"
    else
      line
    end
  end
end
