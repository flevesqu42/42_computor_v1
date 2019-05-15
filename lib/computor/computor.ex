defmodule Computor do
    def start(expression) do
        expression
                    |> String.split("=")
                    |> reduce
                    |> Computor.Solver.solve
    end

    defp reduce([left | [right]]) do
        left_pol = expression_to_polynom(left)
        right_pol = expression_to_polynom(right)

        reduced = Polynom.sub(left_pol, right_pol)

        Computor.Display.puts :initial_form, %{pol1: Polynom.string(left_pol), pol2: Polynom.string(right_pol)}
        Computor.Display.puts :reduced_form, %{pol: Polynom.string reduced}

        reduced
    end

    defp reduce([_]) do
        Computor.Error.critical :incomplete
    end

    defp reduce([_ | [_ | _]]) do
        Computor.Error.critical :too_many_equal
    end

    defp expression_to_polynom(expression) do
        expression
                    |> String.split(~r"[\+\-\*\^\/xX]", include_captures: true)
                    |> Enum.map(&String.trim/1)
                    |> Enum.reject(&:string.is_empty/1)
                    |> Polynom.parse
    end
end
