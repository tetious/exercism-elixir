defmodule RobotSimulator do
  @type robot() :: Robot
  @type direction() :: :north | :east | :south | :west
  @type position() :: {integer(), integer()}

  @directions [:north, :east, :south, :west]

  defmodule Robot do
    defstruct [:position, :direction]
  end

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction, position) :: robot() | {:error, String.t()}
  def create(direction \\ :north, position \\ {0, 0})

  def create(direction, _position) when direction not in @directions,
    do: {:error, "invalid direction"}

  def create(direction, position = {x, y}) when is_integer(x) and is_integer(y),
    do: %Robot{
      position: position,
      direction: Enum.find_index(@directions, &(&1 == direction))
    }

  def create(_direction, _position),
    do: {:error, "invalid position"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot, instructions :: String.t()) :: robot() | {:error, String.t()}
  def simulate(robot, instructions), do: do_simulate(robot, String.graphemes(instructions))

  defp do_simulate(robot, []), do: robot

  defp do_simulate(robot, ["R" | tail]), do: robot |> turn_right() |> do_simulate(tail)
  defp do_simulate(robot, ["L" | tail]), do: robot |> turn_left() |> do_simulate(tail)

  defp do_simulate(robot = %Robot{position: {x, y}}, ["A" | tail]) do
    case robot.direction do
      0 -> %{robot | position: {x, y + 1}}
      1 -> %{robot | position: {x + 1, y}}
      2 -> %{robot | position: {x, y - 1}}
      3 -> %{robot | position: {x - 1, y}}
    end
    |> do_simulate(tail)
  end

  defp do_simulate(_robot, _invalid), do: {:error, "invalid instruction"}

  defp turn_right(robot = %Robot{direction: 3}), do: %{robot | direction: 0}
  defp turn_right(robot = %Robot{direction: dir}), do: %{robot | direction: dir + 1}

  defp turn_left(robot = %Robot{direction: 0}), do: %{robot | direction: 3}
  defp turn_left(robot = %Robot{direction: dir}), do: %{robot | direction: dir - 1}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot) :: direction()
  def direction(robot), do: @directions |> Enum.at(robot.direction)

  @doc """
  Return the robot's position.
  """
  @spec position(robot) :: position()
  def position(robot), do: robot.position
end
