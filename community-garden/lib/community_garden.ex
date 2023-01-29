# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> %{plots: %{}, id: 1} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, &Map.values(&1.plots))
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, &do_register(&1, register_to))
  end

  defp do_register(state, register_to) do
    plot = %Plot{plot_id: state.id, registered_to: register_to}
    state = %{state | id: state.id + 1, plots: Map.put(state.plots, state.id, plot)}
    {plot, state}
  end

  def release(pid, plot_id) do
    Agent.update(pid, &%{&1 | plots: Map.delete(&1.plots, plot_id)})
  end

  def get_registration(pid, plot_id) do
    case Agent.get(pid, &Map.get(&1.plots, plot_id)) do
      nil -> {:not_found, "plot is unregistered"}
      plot -> plot
    end
  end
end
