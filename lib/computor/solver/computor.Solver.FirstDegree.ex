defmodule Computor.Solver.FirstDegree do
    def solution(polynom) do
        x = Computor.Solver.Solution.Classic.get(-polynom[0], polynom[1])
        Computor.Display.puts :one_solution, %{x: x}
    end
end