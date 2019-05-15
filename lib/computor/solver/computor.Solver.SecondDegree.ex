defmodule Computor.Solver.SecondDegree do
    def solution(polynom, 0.0) do
        Computor.Display.puts :delta, %{delta: 0.0}
        x = Computor.Solver.Solution.Classic.get(-polynom[1], (2 * polynom[2]))
        Computor.Display.puts :one_solution_delta, %{x: x}
    end

    def solution(polynom, delta) when delta > 0 do
        Computor.Display.puts :delta, %{delta: delta}
        x1 = Computor.Solver.Solution.Classic.get((-polynom[1] - Maths.sqrt(delta)), (2 * polynom[2]))
        x2 = Computor.Solver.Solution.Classic.get((-polynom[1] + Maths.sqrt(delta)), (2 * polynom[2]))
        Computor.Display.puts :two_solutions_delta, %{x1: x1, x2: x2}
    end

    def solution(polynom, delta) do
        Computor.Display.puts :delta, %{delta: delta}
        x1 = Computor.Solver.Solution.Complex.get(-polynom[1], Maths.sqrt(-delta), (2 * polynom[2]), "-")
        x2 = Computor.Solver.Solution.Complex.get(-polynom[1], Maths.sqrt(-delta), (2 * polynom[2]), "+")

        Computor.Display.puts :two_solutions_delta_neg, %{x1: x1, x2: x2}
    end

end