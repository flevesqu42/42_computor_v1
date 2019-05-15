defmodule Maths do
    def gcd(m, 0) do
        m
    end
    def gcd(m, n) do
        gcd(n, rem(m, n))
    end

    def pow(m, n) when n < 0 do
        1 / solve_pow(m, -n, 1)
    end
    def pow(m, n) do
        solve_pow(m, n, 1)
    end
    
    defp solve_pow(_m, 0, acc) do
        acc
    end
    defp solve_pow(m, n, acc) do
        try do
            solve_pow(m, n - 1, acc * m)
        rescue
            _e in ArithmeticError -> Computor.Error.critical :arithmetic_error
        end
    end

    def sqrt(f) when f > 1 do
        solve_sqrt(f, f, f / 2)
    end
    def sqrt(f) do
        solve_sqrt(0.5, f, 0.5)
    end

    defp solve_sqrt(f, _result, 0.0) do
        f
    end
    defp solve_sqrt(f, result, delta) do
        case f * f do
            s when s > result   -> solve_sqrt(f - delta, result, delta / 2)
            s when s < result   -> solve_sqrt(f + delta, result, delta / 2)
            _                   -> f
        end
    end

end