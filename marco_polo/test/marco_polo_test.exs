defmodule MarcoPoloTest do
  use ExUnit.Case
  doctest MarcoPolo

  test "responds to Marco with Polo" do
      marco = spawn(MarcoPolo, :start, [])
      polo = spawn(MarcoPolo, :start, [])
      send(marco, {:marco, polo})
      assert_receive {:polo, marco}
  end
end
