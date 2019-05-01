defmodule Waterways.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Waterways.Worker.start_link(arg)
      # {Waterways.Worker, arg}
      worker(Waterways.Port, [])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :simple_one_for_one, name: Waterways.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
