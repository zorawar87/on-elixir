defmodule Waterways do
  defstruct [:from, :to]

  def new_port(port) do
    Supervisor.start_child(Waterways.Supervisor, [port])
  end

  def open_channel(from, to, data) do
    Waterways.Port.push_all(from, data)

    %Waterways{from: from, to: to}
  end

  def flush_once(waterway) do
    case Waterways.Port.pop(waterway.from) do
      :error -> :ok
      {:ok, poppedValue} -> Waterways.Port.push(waterway.to, poppedValue)
    end
    IO.puts "#{waterway.from} has #{Waterways.Port.get(waterway.from) |> Enum.join(" ")}"
    IO.puts "#{waterway.to} has #{Waterways.Port.get(waterway.to) |> Enum.join(" ")}"
  end

  def port_info(port), do: Waterways.Port.get(port)
end
