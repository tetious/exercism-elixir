defmodule TakeANumberDeluxe do
  use GenServer
  alias TakeANumberDeluxe.State

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg)
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine), do: GenServer.call(machine, :report_state)

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine), do: GenServer.call(machine, :queue_new_number)

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil),
    do: GenServer.call(machine, {:serve_next_queued_number, priority_number})

  @spec reset_state(pid()) :: :ok
  def reset_state(machine), do: GenServer.cast(machine, :reset_state)

  # Server callbacks
  @impl GenServer
  def init(init_arg) do
    auto_shutdown_timeout = Keyword.get(init_arg, :auto_shutdown_timeout, :infinity)

    case State.new(init_arg[:min_number], init_arg[:max_number], auto_shutdown_timeout) do
      {:ok, state} -> {:ok, state, state.auto_shutdown_timeout}
      {:error, msg} -> {:stop, msg}
    end
  end

  @impl GenServer
  def handle_info(:timeout, state), do: {:stop, :normal, state}

  @impl GenServer
  def handle_info(_, state), do: state |> reply_with()

  @impl GenServer
  def handle_cast(:reset_state, state) do
    {:ok, state} = State.new(state.min_number, state.max_number, state.auto_shutdown_timeout)
    state |> reply_with()
  end

  @impl GenServer
  def handle_call(:report_state, _from, state), do: state |> reply_with(state)

  @impl GenServer
  def handle_call(:queue_new_number, _from, state) do
    case reply = State.queue_new_number(state) do
      {:ok, num, state} -> state |> reply_with({:ok, num})
      _ -> state |> reply_with(reply)
    end
  end

  @impl GenServer
  def handle_call({:serve_next_queued_number, priority_num}, _from, state) do
    case reply = State.serve_next_queued_number(state, priority_num) do
      {:ok, num, state} -> state |> reply_with({:ok, num})
      _ -> state |> reply_with(reply)
    end
  end

  defp reply_with(state, reply), do: {:reply, reply, state, state.auto_shutdown_timeout}
  defp reply_with(state), do: {:noreply, state, state.auto_shutdown_timeout}
end
