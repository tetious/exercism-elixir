defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    inventory |> Enum.sort_by(& &1.price)
  end

  def with_missing_price(inventory) do
    inventory |> Enum.filter(&(&1.price == nil))
  end

  def update_names(inventory, old_word, new_word) do
    inventory |> Enum.map(&put_in(&1.name, String.replace(&1.name, old_word, new_word)))
  end

  def increase_quantity(item, count) do
    item.quantity_by_size
    |> get_and_update_in(&{&1, Map.new(&1, fn {k, v} -> {k, v + count} end)})
    |> elem(1)
  end

  def total_quantity(item) do
    item.quantity_by_size |> Enum.reduce(0, fn {_k, v}, a -> a + v end)
  end
end
