defmodule Polynom.String do
    defmacrop is_only_x(head) do
        quote do: abs(elem(unquote(head), 1)) == 1 and elem(unquote(head), 0) != 0
    end

    defmacrop is_truncated(elem) do
        quote do: is_float(unquote(elem)) and trunc(unquote(elem)) == unquote(elem)
    end

    def get(polynom, str, opt \\ :normal)

    def get([head | tail], str, opt) when elem(head, 1) == 0 do
        get(tail, str, opt)
    end

    def get([head | tail], str, opt) when is_only_x(head) do
        str = case opt do
            :normal -> if elem(head, 1) < 0 do "#{str} - " else "#{str} + " end
            :first  -> if elem(head, 1) < 0 do "-" else "" end
        end
        get(tail, str <> "#{power elem(head, 0), :only}")
    end

    def get([head | tail], str, opt) do
        str = case opt do
            :first  -> "#{coef elem(head, 1), opt}#{power elem(head, 0)}"
            :normal -> "#{str} #{coef elem(head, 1), opt}#{power elem(head, 0)}"
        end
        get(tail, str)
    end

    def get([], str, _opt) when str == "" do
        "0"
    end

    def get([], str, _opt) do
        str
    end

    defp power(pol, opt \\ :none)

    defp power(pol, _opt) when pol == 0 do
        ""
    end

    defp power(pol, opt) when pol == 1 do
        case opt do
            :only   -> "X"
            _       -> " * X"
        end
    end

    defp power(pol, opt) do
        case opt do
            :only   -> "X^#{pol}"
            _       -> " * X^#{pol}"
        end
    end

    defp coef(pol, opt) when is_truncated(pol) do
        truncated = coef_string trunc(pol), opt
        normal = coef_string pol, opt

        case String.length(truncated) <= String.length(normal) do
            true    -> truncated
            false   -> normal
        end
    end
    defp coef(pol, opt) do
        coef_string pol, opt
    end

    defp coef_string(pol, opt) when pol >= 0 do
        case opt do
            :normal -> "+ #{pol}"
            :first  -> "#{pol}"
        end
    end

    defp coef_string(pol, opt) do
        case opt do
            :normal -> "- #{- pol}"
            :first  -> "#{pol}"
        end
    end

end
