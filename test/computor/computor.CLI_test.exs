defmodule Computor.CLITest do
  use ExUnit.Case, async: true

  import ExUnit.CaptureIO

  test "Too many arg" do
      assert Computor.CLI.main(["a", "b"]) == :too_many
  end

  test "No args" do
      assert Computor.CLI.main([]) == :at_least_one
  end

  test "Too many equal" do
      assert Computor.CLI.main(["42 = x = 1"]) == :too_many_equal
  end

  test "Wrong maths" do
      assert Computor.CLI.main(["42 = 1"]) == :no_solution
  end
end
