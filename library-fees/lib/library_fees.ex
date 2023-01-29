defmodule LibraryFees do
  def datetime_from_string(string) do
    {:ok, date} = NaiveDateTime.from_iso8601(string)
    date
  end

  def before_noon?(datetime) do
    datetime |> NaiveDateTime.to_time() |> then(& &1.hour < 12)
  end

  def return_date(checkout_datetime) do
    to_add = if before_noon?(checkout_datetime), do: 28, else: 29
    checkout_datetime |> NaiveDateTime.add(to_add, :day) |> NaiveDateTime.to_date()
  end

  def days_late(planned_return_date, actual_return_datetime) do
    returned = actual_return_datetime |> NaiveDateTime.to_date()

    case Date.diff(returned, planned_return_date) do
      result when result > 0 -> result
      _ -> 0
    end
  end

  def monday?(datetime), do: datetime |> NaiveDateTime.to_date() |> Date.day_of_week() == 1

  def calculate_late_fee(checkout, return, rate) do
    expected_return = checkout |> datetime_from_string() |> return_date()
    returned = return |> datetime_from_string()

    case days_late(expected_return, returned) do
      days_late when days_late > 0 ->
        if monday?(returned), do: div(rate * days_late, 2), else: rate * days_late

      _ ->
        0
    end
  end
end
