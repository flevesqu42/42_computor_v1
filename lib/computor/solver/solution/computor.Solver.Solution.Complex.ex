defmodule Computor.Solver.Solution.Complex do
    def get(f1, f2, f3, symbol) do
        solution_1 = complex_solution_divided(f1, f2, f3, symbol)
        solution_2 = complex_solution_not_divided(f1, f2, f3, symbol)

        Computor.Solver.Solution.get_best_soluce solution_1, solution_2
    end

    defp complex_solution_divided(f1, 0.0, f3, _symbol) do
        "#{Computor.Solver.Solution.trunc_if_necessary(f1 / f3)}"
    end
    defp complex_solution_divided(0.0, f2, f3, "-") do
        "#{Computor.Solver.Solution.trunc_if_necessary(-f2 / f3)}i"
    end
    defp complex_solution_divided(0.0, f2, f3, "+") do
        "#{Computor.Solver.Solution.trunc_if_necessary(f2 / f3)}i"
    end
    defp complex_solution_divided(f1, f2, f3, symbol) do
        p1 = Computor.Solver.Solution.trunc_if_necessary(f1 / f3)
        p2 = Computor.Solver.Solution.trunc_if_necessary(f2 / f3)

        {symbol, p2} = get_symbol_and_number(symbol, p2)

        "#{p1} #{symbol} #{p2}i"
    end


    defp complex_solution_not_divided(f1, 0.0, f3, _symbol) do
        "#{Computor.Solver.Solution.trunc_if_necessary f1} / #{Computor.Solver.Solution.trunc_if_necessary f3}"
    end
    defp complex_solution_not_divided(0.0, f2, f3, "-") do
        "#{Computor.Solver.Solution.trunc_if_necessary -f2}i / #{Computor.Solver.Solution.trunc_if_necessary f3}"
    end
    defp complex_solution_not_divided(0.0, f2, f3, "+") do
        "#{Computor.Solver.Solution.trunc_if_necessary f2}i / #{Computor.Solver.Solution.trunc_if_necessary f3}"
    end
    defp complex_solution_not_divided(f1, f2, f3, symbol) do
        {symbol, f2} = get_symbol_and_number(symbol, f2)

        "(#{Computor.Solver.Solution.trunc_if_necessary f1} #{symbol} #{Computor.Solver.Solution.trunc_if_necessary f2}i) / #{Computor.Solver.Solution.trunc_if_necessary f3}"
    end


    defp get_symbol_and_number("+", number) when number < 0 do
        {"-", -number}
    end
    defp get_symbol_and_number("-", number) when number < 0 do
        {"+", -number}
    end
    defp get_symbol_and_number(symbol, number) do
        {symbol, number}
    end
end