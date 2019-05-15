defmodule Computor.Solver.Solution do

    def get_best_soluce(soluce_1, soluce_2) do
        case String.length(soluce_1) <= String.length(soluce_2) do
            true -> soluce_1
            _    -> soluce_2
        end
    end

    def trunc_if_necessary(f) do
        case ((f == trunc f) and (String.length("#{f}") > String.length("#{trunc f}"))) do
            true -> trunc f
            _    -> f
        end
    end
end