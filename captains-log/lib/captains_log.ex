defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class() do
    @planetary_classes |> Enum.random()
  end

  def random_ship_registry_number(), do: "NCC-#{Enum.random(1000..9999)}"

  def random_stardate(), do: :rand.uniform(999) + :rand.uniform() + 41000

  def format_stardate(stardate), do: :io_lib.format("~.1f", [stardate]) |> to_string()
end
