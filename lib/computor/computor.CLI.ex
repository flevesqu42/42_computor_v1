defmodule Computor.CLI do
    def main([head]) do
        Computor.start head
    end

    def main([_ | _]) do
        Computor.Error.critical :too_many
    end

    def main([]) do
        Computor.Error.critical :at_least_one
    end
end
