defmodule Computor.Solver do
    defmacrop degree_is_more_than_acc(x, acc) do
        quote do: elem(unquote(x), 0) > unquote(acc) and elem(unquote(x), 1) != 0
    end

    def solve(polynom) when is_map(polynom) do
        try do
            deg = degree polynom
            Computor.Display.puts :polynomial_degree, %{deg: deg}
            case deg do
                2   -> Computor.Solver.SecondDegree.solution(polynom, (polynom[1] * polynom[1]) - (4 * polynom[2] * polynom[0]))
                1   -> Computor.Solver.FirstDegree.solution(polynom)
                0   -> Computor.Solver.ZeroDegree.solution(polynom)
                _   -> cannot_solve()
            end
        rescue
            _e in ArithmeticError -> Computor.Error.critical :arithmetic_error
        end
    end

    def solve(error) do
        error
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

    defp cannot_solve() do
        Computor.Display.puts :cannot_solve
    end

end
