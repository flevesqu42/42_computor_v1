defmodule Computor.Display do
    def puts(what, opts \\ %{})

    def puts(what, opts) do
        what_verbose what, opts
        what
    end

    defp what_verbose(what, opts) do
        case what do
            :first_degree_resolution  -> "Resolution:\t\t#{opts[:f1]} / #{opts[:f2]}"
            :delta                    -> "Discriminant:\t\tb² - 4ac = #{opts[:delta]}"
            # :first_degree_resolution -> "Resolution:\t#{opts[:f1] / opts[:f2]}"
            # :first_degree_resolution -> "Resolution:\t#{opts[:f1] / opts[:f2]}"
            :initial_form             -> "Initial form:\t\t#{opts[:pol1]} = #{opts[:pol2]}"
            :reduced_form             -> "Reduced form:\t\t#{opts[:pol]} = 0"
            :polynomial_degree        -> "Polynomial degree:\t#{opts[:deg]}"
            :cannot_solve             -> "I can't solve this."
            :all_solutions            -> "All numbers are solutions !"
            :no_solution              -> "Sorry, there is no solution, one does not simply play with maths. :("
            :one_solution             -> "The solution is:\t#{opts[:x]}"
            :one_solution_delta       -> "Discriminant is equal to zero, the solution is:\t#{opts[:x]}"
            :two_solutions_delta      -> "Discriminant is strictly positive, the two solutions are:\n#{opts[:x1]}\n#{opts[:x2]}"
            :two_solutions_delta_neg  -> "Discriminant is negative, the two solutions are:\n#{opts[:x1]}\n#{opts[:x2]}"
        end |> IO.puts
    end
end
