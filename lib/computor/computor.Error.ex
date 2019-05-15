defmodule Computor.Error do
    def critical(cause) do
        cause_verbose cause
        case Application.get_env(:computor, :environment) do
            :test -> cause
            _ -> System.halt 1
        end
    end

    defp cause_verbose(cause) do
        usage = "\nUsage: ./computor [expression]"
        case cause do
            :arithmetic_error   -> "Error: number is too big, evaluation is impossible"
            :parse_error        -> "Error: number is too big, parse is impossible"
            :divide_by_zero     -> "Error: divide by zero"
            :too_many           -> "Error: too many arguments" <> usage
            :at_least_one       -> "Error: computor must take one argument" <> usage
            :too_many_equal     -> "Error: too many equality in this expression"
            :form               -> "Error: polynomial form must be [A * X^N] with N a real integer"
            :incomplete_form    -> "Error: incomplete expression."
            :incomplete         -> "Error: incomplete expression, add \" = 0\" to complete it"
            :parse_error_int    -> "Error: parse integer failed, entry bad formated, polynomial form must be [A * X^N] with N a real integer"
            :parse_error_float  -> "Error: parse float failed, entry bad formated, polynomial form must be [A * X^N] with N a real integer"
            :neg_power          -> "Error: Polynom doesn't support negative power, cannot define polynomial degree and resolve."
            _                   -> "Error: unknow error"
        end |> (&IO.puts(:stderr, &1)).()
    end
end
