defmodule Chef do
  @moduledoc """
  Functions for a Potion Chef that help get started with elixir
  """

  @doc """
  The potion chef Greets `name` with the time

  ## Parameters
    - name: String representing the entity to greet

  ## Returns
    `:ok`
  """
  def greet(name \\ "Class") do
    IO.puts "Hello, #{name}!" <> "\nI'm your Potion Chef.\nIt's #{DateTime.utc_now} right now."
  end

  @preference %{type: "Indian", portions: 5, temp: :hot}
  @menu ["Cocio-Milk", "Adrak-Chai", "Matcha-Tea"]

  @doc """
  get potion preference 
  """
  def get_pref, do: @preference

  @doc """
  get formatted menu
  """
  def get_menu, do: "Today's Potions: " <> (@menu |> Enum.join(", "))

  @doc """
  get raw menu list
  """
  def get_raw_menu, do: @menu

  
  @doc """
  makes a potion of different types
  """
  def make_potion(%{type: "Danish"}), do: :cocio_milk
  def make_potion(%{type: "Indian"}), do: :adrak_chai
  def make_potion(%{type: "Japanese"}), do: :matcha_tea
  def make_potion(_), do: :elixir

end

defmodule Utils do
  def cycle([]), do: nil
  def cycle([h|t]), do: t ++ [h]
end

# Lists, Tuples, Atoms, Int, Float, Strings, Sigils
