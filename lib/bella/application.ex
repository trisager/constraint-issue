defmodule Bella.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [Bella.Repo]

    opts = [strategy: :one_for_one, name: Bella.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
