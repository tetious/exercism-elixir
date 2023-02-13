defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    digits = number |> Integer.digits()
    len = digits |> length()
    number == digits |> Enum.reduce(0, &(&1 ** len + &2))
  end
end
