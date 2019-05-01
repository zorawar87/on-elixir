defmodule ChefTest do
  use ExUnit.Case, async: true
  doctest Chef

  test "think of variables as named values" do
    namedValue = 1
    assert namedValue == 1
  end

  test "they can be rebound on the left side" do
    namedValue = 1
    namedValue = :adrak_chai

    assert :true == true
    assert :false == false
    assert :nil == nil

    result =
      case Chef.make_potion(Chef.get_pref) do
        ^namedValue -> "Yummmmm"
        someVal -> "what is this? this is #{someVal}"
      end
    assert result == "Yummmmm"
  end

  test "and can be pattern matched on the right side" do
    namedValue = Chef.make_potion(Chef.get_pref)
    :adrak_chai = namedValue
    assert namedValue == :adrak_chai 
  end

  test "incorrect right hand pattern matching raises a MatchError" do
    namedValue = Chef.make_potion(Chef.get_pref)
    assert_raise MatchError, fn ->
      :cocio_milk = namedValue
    end
  end

  test "pattern matching can be partially applied" do 
    "Today's Potions: " <> potions = Chef.get_menu
    assert potions == "Cocio-Milk, Adrak-Chai, Matcha-Tea"
  end

  test "lists can also be pattern matched (like in Haskell)" do
    "Today's Potions: " <> potions = Chef.get_menu
    # potions =
    #String.split(String.replace(String.downcase(potions), "-", " "), ", ")
    potions = potions
              |> String.downcase
              |> String.replace("-"," ")
              |> String.split(", ")

    [x|xs] = Utils.cycle(potions)
    assert x == "adrak chai"
    assert xs == ["matcha tea", "cocio milk"]
  end

  test "Maps & Atoms are fundamental to Elixir. They can be partially matched via func arguments" do
    adrakChai = Chef.get_pref
    assert adrakChai.portions == 5
    assert adrakChai.temp == :hot
    assert Chef.make_potion(adrakChai) == :adrak_chai
  end

  test "maps have easy update syntax." do
    matchaT = %{ Chef.get_pref | type: "Japanese", portions: 3}
    assert matchaT.portions == 3
    assert matchaT.temp == :hot
    assert Chef.make_potion(matchaT) == :matcha_tea
  end

  test "regex is a first-class entity thanks to sigils!" do
    hasCocio = ~r/[Cc]ocio/
    assert Chef.get_menu =~ hasCocio
  end

end
