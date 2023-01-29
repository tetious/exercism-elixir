defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    distance = :math.sqrt(x**2 + y**2)
    cond do
      distance <= 10 and distance > 5 -> 1
      distance <= 5 and distance > 1 -> 5
      distance <= 1 -> 10
      true -> 0
    end
  end
end
