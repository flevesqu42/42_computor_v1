defmodule Computor.Solver.ZeroDegree do
    def solution(polynom) do
        case polynom[0] do
            0.0 -> :all_solutions
            _   -> :no_solution
        end |> Computor.Display.puts
    end
end
