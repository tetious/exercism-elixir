defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    @message "stack underflow occurred"
    defexception message: @message

    @impl true
    def exception(context \\ []) do
      case context do
        [] -> %StackUnderflowError{}
        _ -> %StackUnderflowError{message: "#{@message}, context: #{context}"}
      end
    end
  end

  def divide(stack) when length(stack) < 2, do: raise(StackUnderflowError, "when dividing")
  def divide([0, _]), do: raise(DivisionByZeroError)
  def divide([divisor, dividend]), do: div(dividend, divisor)
end
