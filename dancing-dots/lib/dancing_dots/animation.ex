defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts) :: {:ok, opts} | {:error, error}
  @callback handle_frame(dot, frame_number, opts) :: dot

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  alias DancingDots.Dot
  use DancingDots.Animation

  @impl true
  def handle_frame(%Dot{opacity: opacity} = dot, frame_number, _opts) do
    if rem(frame_number, 4) == 0, do: %{dot | opacity: opacity / 2}, else: dot
  end
end

defmodule DancingDots.Zoom do
  alias DancingDots.Dot
  use DancingDots.Animation

  @impl true
  def init(opts) do
    velocity = opts[:velocity]

    if is_number(velocity),
      do: {:ok, opts},
      else:
        {:error,
         "The :velocity option is required, and its value must be a number. Got: #{inspect(velocity)}"}
  end

  @impl true
  def handle_frame(%Dot{radius: radius} = dot, frame_number, velocity: velocity) do
    %{dot | radius: radius + (frame_number - 1) * velocity}
  end
end
