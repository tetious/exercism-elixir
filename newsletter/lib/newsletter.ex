defmodule Newsletter do
  def read_emails(path), do: path |> File.read!() |> String.split()

  def open_log(path), do: path |> File.open!([:write])

  def log_sent_email(pid, email), do: IO.puts(pid, email)

  def close_log(pid), do: File.close(pid)

  def send_newsletter(emails_path, log_path, send_fun) do
    log = open_log(log_path)

    emails_path
    |> read_emails()
    |> Enum.each(&do_send_newsletter(&1, log, send_fun))

    close_log(log)
  end

  defp do_send_newsletter(email, log, send_fun) do
    case send_fun.(email) do
      :ok -> log_sent_email(log, email)
      _ -> nil
    end
  end
end
