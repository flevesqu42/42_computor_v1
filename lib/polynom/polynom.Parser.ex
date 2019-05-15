defmodule Polynom.Parser do
    defmacrop is_add_or_sub(elem) do
        quote do: unquote(elem) == "+" or unquote(elem) == "-"
    end

    defmacrop is_divide_or_mult(elem) do
        quote do: unquote(elem) == "*" or unquote(elem) == "/"
    end

    defmacrop is_x(elem) do
        quote do: unquote(elem) == "x" or unquote(elem) == "X"
    end

    def compute([], map) do
        map
    end
    def compute(list, map) do
        {list, polynom} = get_monom(list)
        compute list, Polynom.add(map, polynom)
    end

    defp get_monom(list, monom \\ {0, 1.0}, operator \\ "*")
    defp get_monom(list, monom, "/") do
        parse_operation divide_monom(list, monom)
    end
    defp get_monom(list, monom, "*") do
        parse_operation mult_monom(list, monom)
    end

    defp parse_operation(tuple) do
        case tuple do
            {pow, coef, []}                                                 -> {[], %{pow => coef}}
            {pow, coef, [operator | list]} when is_add_or_sub(operator)     -> {[operator | list], %{pow => coef}}
            {pow, coef, [operator | list]} when is_divide_or_mult(operator) -> get_monom(list, {pow, coef}, operator)
            {pow, coef, list}                                               -> get_monom(list, {pow, coef})
        end
    end

    defp mult_monom(["-" | ["-" | [x | tail]]], monom) when is_x(x) do
        mult_monom(["+" | [x | tail]], monom)
    end
    defp mult_monom(["+" | ["+" | [x | tail]]], monom) when is_x(x) do
        mult_monom(["+" | [x | tail]], monom)
    end
    defp mult_monom(["+" | ["-" | [x | tail]]], monom) when is_x(x) do
        mult_monom(["-" | [x | tail]], monom)
    end
    defp mult_monom(["-" | ["+" | [x | tail]]], monom) when is_x(x) do
        mult_monom(["-" | [x | tail]], monom)
    end
    defp mult_monom(["-" | ["-" | tail]], monom) do
        mult_monom(["+" | tail], monom)
    end
    defp mult_monom(["+" | ["+" | tail]], monom) do
        mult_monom(["+" | tail], monom)
    end
    defp mult_monom(["+" | ["-" | tail]], monom) do
        mult_monom(["-" | tail], monom)
    end
    defp mult_monom(["-" | ["+" | tail]], monom) do
        mult_monom(["-" | tail], monom)
    end
    defp mult_monom(["+" | [x | tail]], monom) when is_x(x) do
        {power, tail} = check_power(tail)
        {elem(monom, 0) + power, elem(monom, 1), tail}
    end
    defp mult_monom(["-" | [x | tail]], monom) when is_x(x) do
        {power, tail} = check_power(tail)
        {elem(monom, 0) + power, -elem(monom, 1), tail}
    end
    defp mult_monom([x | tail], monom) when is_x(x) do
        {power, tail} = check_power(tail)
        {elem(monom, 0) + power, elem(monom, 1), tail}
    end
    defp mult_monom(["+" | [num | tail]], monom) do
        {power, tail} = check_power(tail)
        {elem(monom, 0), elem(monom, 1) * Maths.pow(get_coef(num), power), tail}
    end
    defp mult_monom(["-" | [num | tail]], monom) do
        {power, tail} = check_power(tail)
        {elem(monom, 0), -elem(monom, 1) * Maths.pow(get_coef(num), power), tail}
    end
    defp mult_monom([num | tail], monom) do
        {power, tail} = check_power(tail)
        {elem(monom, 0), elem(monom, 1) * Maths.pow(get_coef(num), power), tail}
    end
    defp mult_monom([], _monom) do
        Computor.Error.critical :incomplete_form
    end

    defp divide_monom(["-" | ["-" | [x | tail]]], monom) when is_x(x) do
        divide_monom(["+" | [x | tail]], monom)
    end
    defp divide_monom(["+" | ["+" | [x | tail]]], monom) when is_x(x) do
        divide_monom(["+" | [x | tail]], monom)
    end
    defp divide_monom(["+" | ["-" | [x | tail]]], monom) when is_x(x) do
        divide_monom(["-" | [x | tail]], monom)
    end
    defp divide_monom(["-" | ["+" | [x | tail]]], monom) when is_x(x) do
        divide_monom(["-" | [x | tail]], monom)
    end
    defp divide_monom(["-" | ["-" | tail]], monom) do
        divide_monom(["+" | tail], monom)
    end
    defp divide_monom(["+" | ["+" | tail]], monom) do
        divide_monom(["+" | tail], monom)
    end
    defp divide_monom(["+" | ["-" | tail]], monom) do
        divide_monom(["-" | tail], monom)
    end
    defp divide_monom(["-" | ["+" | tail]], monom) do
        divide_monom(["-" | tail], monom)
    end
    defp divide_monom(["+" | [x | tail]], monom) when is_x(x) do
        {power, tail} = check_power(tail)
        {elem(monom, 0) - power, elem(monom, 1), tail}
    end
    defp divide_monom(["-" | [x | tail]], monom) when is_x(x) do
        {power, tail} = check_power(tail)
        {elem(monom, 0) - power, -elem(monom, 1), tail}
    end
    defp divide_monom([x | tail], monom) when is_x(x) do
        {power, tail} = check_power(tail)
        {elem(monom, 0) - power, elem(monom, 1), tail}
    end
    defp divide_monom(["+" | [num | tail]], monom) do
        {power, tail} = check_power(tail)
        coef = get_coef(num)
        {elem(monom, 0), safe_divide(elem(monom, 1), Maths.pow(coef, power)), tail}
    end
    defp divide_monom(["-" | [num | tail]], monom) do
        {power, tail} = check_power(tail)
        coef = get_coef(num)
        {elem(monom, 0), safe_divide(-elem(monom, 1), Maths.pow(coef, power)), tail}
    end
    defp divide_monom([num | tail], monom) do
        {power, tail} = check_power(tail)
        coef = get_coef(num)
        {elem(monom, 0), safe_divide(elem(monom, 1), Maths.pow(coef, power)), tail}
    end
    defp divide_monom([], _monom) do        
        Computor.Error.critical :incomplete_form
    end
    
    defp safe_divide(_divided, 0) do
        Computor.Error.critical :divide_by_zero
    end
    defp safe_divide(_divided, 0.0) do
        Computor.Error.critical :divide_by_zero
    end
    defp safe_divide(divided, divisor) do
        divided / divisor
    end

    defp check_power(["^" | ["-" | ["-" | tail]]]) do
        check_power(["^" | ["+" | tail]])
    end
    defp check_power(["^" | ["+" | ["+" | tail]]]) do
        check_power(["^" | ["+" | tail]])
    end
    defp check_power(["^" | ["-" | ["+" | tail]]]) do
        check_power(["^" | ["-" | tail]])
    end
    defp check_power(["^" | ["+" | ["-" | tail]]]) do
        check_power(["^" | ["-" | tail]])
    end
    defp check_power(["^" | [operator | [num | list]]]) when is_add_or_sub(operator) do
        {power, list} = check_power(list)
        {Maths.pow(get_power(operator <> num), power), list}
    end
    defp check_power(["^" | [num | list]]) do
        {power, list} = check_power(list)
        {Maths.pow(get_power(num), power), list}
    end
    defp check_power(list) do
        {1, list}
    end

    defp get_coef(num) do
        try do
            case Float.parse num do
                {num, ""}   -> num
                :error      -> Computor.Error.critical :parse_error_float
                _           -> Computor.Error.critical :parse_error_float
            end
        rescue
            _e in ArgumentError -> Computor.Error.critical :parse_error
        end
    end

    defp get_power(num) do
        try do
            case Integer.parse num do
                {num, ""}   -> num
                :error      -> Computor.Error.critical :parse_error_int
                _           -> Computor.Error.critical :parse_error_int
            end
        rescue
            _e in ArgumentError -> Computor.Error.critical :parse_error
        end
    end
end
