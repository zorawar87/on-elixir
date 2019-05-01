defmodule Waterways do
  @moduledoc """
  This module simulates waterways that connects port cities.
  """

  defstruct [:from, :to]

  @doc """
  Spawn a port city process by the name of `portCity`
  """
  def new_port(portCity) do
    Waterways.Port.start_link(portCity)
  end

  @doc """
  Create a link between two port cities: `from` -> `to`
  `data` is buffered in `from` port city,
  ready to be deployed to `to` port city
  """
  def open_channel(from, to, data) do
    Waterways.Port.push_all(from, data)

    %Waterways{from: from, to: to}
  end

  @doc """
  Flush/Deploy a single value between the waterway link
  """
  def flush_once(waterway) do
    case Waterways.Port.pop(waterway.from) do
      :error -> :ok
      {:ok, poppedValue} -> Waterways.Port.push(waterway.to, poppedValue)
    end
    IO.puts "#{waterway.from} has #{Waterways.Port.get(waterway.from) |> Enum.join(" ")}"
    IO.puts "#{waterway.to} has #{Waterways.Port.get(waterway.to) |> Enum.join(" ")}"
  end

  @doc """
  Get the information in the `portCity`
  """
  def port_info(portCity), do: Waterways.Port.get(portCity)

  def kill_port(portCity) do
    Process.unlink(Process.whereis(portCity))
    Process.exit(Process.whereis(portCity), :shutdown)
  end
end
