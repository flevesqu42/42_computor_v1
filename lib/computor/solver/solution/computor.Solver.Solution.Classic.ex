defmodule Computor.Solver.Solution.Classic do    
    def get(f1, f2) do
        x_float = "#{Computor.Solver.Solution.trunc_if_necessary(f1 / f2)}"
        x_fract = fractional_solution f1, f2

        Computor.Solver.Solution.get_best_soluce x_float, x_fract
    end

    defmacrop are_negatives(f1, f2) do
        quote do: unquote(f1) < 0 and unquote(f2) < 0
    end

    defp fractional_solution(f1, f2) when are_negatives(f1, f2) do
        fractional_solution(-f1, -f2)
    end
    defp fractional_solution(f1, f2) do
        {f1, f2} = remove_fractional_part(f1, f2)

        "#{Computor.Solver.Solution.trunc_if_necessary(f1 / Maths.gcd(f1, f2))} / #{Computor.Solver.Solution.trunc_if_necessary(f2 / Maths.gcd(f1, f2))}"
    end

    defmacrop are_fractionals(f1, f2, acc) do
        quote do: (unquote(f1) * unquote(acc) != trunc(unquote(f1) * unquote(acc))) or (unquote(f2) * unquote(acc) != trunc(unquote(f2) * unquote(acc)))
    end

    defp remove_fractional_part(f1, f2, acc \\ 1)
    defp remove_fractional_part(f1, f2, acc) when are_fractionals(f1, f2, acc) do
        remove_fractional_part(f1, f2, acc * 10)
    end
    defp remove_fractional_part(f1, f2, acc) do
        {trunc(f1 * acc), trunc(f2 * acc)}
    end
end