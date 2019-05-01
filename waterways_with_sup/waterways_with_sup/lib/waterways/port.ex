defmodule Waterways.Port do
  def start_link(city) do
    Agent.start_link(fn -> [] end, name: city)
  end

  def get(city) do
    Agent.get(city, fn list -> list end)
  end

  def push_all(city, list) do
    list |> Enum.reverse |> Enum.each(fn x -> Waterways.Port.push(city, x) end)
  end

  def push(city, value) do
    Agent.update(city, fn list -> [value|list] end)
  end

  def pop(city) do
    Agent.get_and_update(city, fn
      []    -> {:error, []}
      [x|xs] -> {{:ok, x}, xs}
    end)
  end

end
