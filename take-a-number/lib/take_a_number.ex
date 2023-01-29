defmodule TakeANumber do
  def start() do
    spawn(fn -> loop(0) end)
  end

  def loop(num) do
    receive do
      {:report_state, sender_pid} -> sender_pid |> send(num) |> loop()
      {:take_a_number, sender_pid} -> sender_pid |> send(num + 1) |> loop()
      :stop -> nil
      _ -> loop(num)
    end
  end
end
