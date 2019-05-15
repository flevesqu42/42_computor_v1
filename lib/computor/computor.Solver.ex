defmodule Computor.Solver do
    defmacro degree_is_more_than_acc(x, acc) do
        quote do: elem(unquote(x), 0) > unquote(acc) and elem(unquote(x), 1) != 0
    end

    def solve(polynom) when is_map(polynom) do
        deg = degree polynom
        Computor.Display.puts :reduced_form, %{pol: Polynom.string polynom}
        Computor.Display.puts :polynomial_degree, %{deg: deg}
        case deg do
            2   -> second_degree_solution(polynom, :math.pow(polynom[1], 2) - (4 * polynom[2] * polynom[0]))
            1   -> first_degree_solution polynom
            0   -> zero_degree_solution polynom
            _   -> cannot_solve()
        end
    end

    def solve(error) do
        error
    end

    def cannot_solve() do
        Computor.Display.puts :cannot_solve
    end

    def zero_degree_solution(polynom) do
        case polynom[0] do
            0.0 -> :all_solutions
            _   -> :no_solution
        end |> Computor.Display.puts
    end


    def first_degree_solution(polynom) do
        x = -polynom[0] / polynom[1]
        Computor.Display.puts :one_solution, %{x: x}
    end

    defp second_degree_solution(polynom, delta) when delta > 0 do
        x1 = (-polynom[1] - :math.sqrt(delta)) / (2 * polynom[2])
        x2 = (-polynom[1] + :math.sqrt(delta)) / (2 * polynom[2])
        Computor.Display.puts :two_solutions_delta, %{x1: x1, x2: x2}
    end

    defp second_degree_solution(polynom, delta) when delta == 0 do
        x = -(polynom[1] / (2 * polynom[2]))
        Computor.Display.puts :one_solution_delta, %{x: x}
    end

    defp second_degree_solution(_polynom, _discriminant) do
        Computor.Display.puts :no_solution_delta
    end

    defp degree(polynom) when is_map(polynom) do
        polynom
                |> Map.to_list
                |> degree
    end

    defp degree(polynom) do
        Enum.reduce polynom, 0, &acc_degree/2
    end

    defp acc_degree(x, _acc) when elem(x, 0) < 0 do
        Computor.Error.critical :neg_power
    end

    defp acc_degree(x, acc) when degree_is_more_than_acc(x, acc) do
        elem x, 0
    end

    defp acc_degree(_x, acc) do
        acc
    end
end
