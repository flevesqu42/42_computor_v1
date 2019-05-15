defmodule Polynom do
    defmacrop two_arguments_are_maps(a1, a2) do
        quote do: is_map(unquote(a1)) and is_map(unquote(a2))
    end

    def string(polynom) do
        polynom
                |> Map.to_list
                |> Enum.sort(fn a, b -> elem(a, 0) >= elem(b, 0) end)
                |> Polynom.String.get("", :first)
    end

    def add(p1, p2) when two_arguments_are_maps(p1, p2) do
        Map.merge p1, p2, fn _k, v1, v2 -> v1 + v2 end
    end

    def sub(p1, p2) when two_arguments_are_maps(p1, p2) do
        Map.merge p1, p2, fn _k, v1, v2 -> v1 - v2 end
    end

    def parse([]) do
        Computor.Error.critical :incomplete_form
    end

    def parse(expression) do
        Polynom.Parser.compute expression, %{0 => 0.0, 1 => 0.0, 2 => 0.0}
    end
end
