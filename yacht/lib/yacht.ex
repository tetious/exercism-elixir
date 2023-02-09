defmodule Yacht do
  @type category ::
          :ones
          | :twos
          | :threes
          | :fours
          | :fives
          | :sixes
          | :full_house
          | :four_of_a_kind
          | :little_straight
          | :big_straight
          | :choice
          | :yacht

  @numeric [:ones, :twos, :threes, :fours, :fives, :sixes]

  @doc """
  Calculate the score of 5 dice using the given category's scoring method.
  """
  @spec score(category :: category(), dice :: [integer]) :: integer
  def score(category, dice), do: do_score(category, dice |> Enum.sort())

  defp do_score(number, dice) when number in @numeric do
    die = Enum.find_index(@numeric, &(&1 == number)) + 1
    Enum.count(dice, &(&1 == die)) * die
  end

  defp do_score(:full_house, [a, a, a, b, b] = dice) when a != b, do: dice |> Enum.sum()
  defp do_score(:full_house, [b, b, a, a, a] = dice) when a != b, do: dice |> Enum.sum()

  defp do_score(:four_of_a_kind, [d, d, d, d, _]), do: d * 4
  defp do_score(:four_of_a_kind, [_, d, d, d, d]), do: d * 4

  defp do_score(:little_straight, [1, 2, 3, 4, 5]), do: 30
  defp do_score(:big_straight, [2, 3, 4, 5, 6]), do: 30
  defp do_score(:choice, dice), do: dice |> Enum.sum()

  defp do_score(:yacht, [d, d, d, d, d]), do: 50

  defp do_score(_category, _dice), do: 0
end
