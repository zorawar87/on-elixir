defmodule Waterways.Port do
  @moduledoc """
  Create a Port City that can store elements 
  in a list!
  """

  @doc """
  Spawn a port city process by the name of `portCity`
  """
  def start_link(portCity) do
    Agent.start_link(fn -> [] end, name: portCity)
  end

  @doc """
  Get the information in the `portCity`
  """
  def get(portCity) do
    Agent.get(portCity, fn list -> list end)
  end

  @doc """
  Add elements of `list` to the `portCity`
  """
  def push_all(portCity, list) do
    list |> Enum.reverse |> Enum.each(fn x -> Waterways.Port.push(portCity, x) end)
  end

  @doc """
  Add a single `value` to the `portCity`
  """
  def push(portCity, value) do
    Agent.update(portCity, fn list -> [value|list] end)
  end

  @doc """
  Remove the most recent value. 
  ## Returns
  the value removed
  """
  def pop(portCity) do
    Agent.get_and_update(portCity, fn
      []    -> {:error, []}
      [x|xs] -> {{:ok, x}, xs}
    end)
  end

end
