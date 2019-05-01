defmodule MarcoPolo do
  @moduledoc """
  Demonstrates message passing between processes via a Marco-Polo call-response
  """

  @doc """
  create a new MarcoPolo server!
  """
  def new_link do
    spawn(MarcoPolo, :start, [])
  end
  
  @doc """
  start listening for marco or polo messages
  """
  def start do
      listenForMessages()
  end

  @doc """
  Listen for marco or polo messages, and respond appropriately
  """
  def listenForMessages() do
    receive do 
        {"marco", from} -> 
            IO.puts "Marco ---> "
            :timer.sleep 500
            send(from, {"polo", self()})
        {"polo", from} -> 
            IO.puts "          <--- Polo"
            :timer.sleep 500
            send(from, {"marco", self()})
    end
    listenForMessages()
  end
end
