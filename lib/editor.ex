defmodule Editor do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      supervisor(Editor.Repo, []),
      supervisor(Editor.Endpoint, []),
      supervisor(Editor.Presence, []),
      # Start your own worker by calling: Editor.Worker.start_link(arg1, arg2, arg3)
      # worker(Editor.Worker, [arg1, arg2, arg3]),
      worker(RethinkDatabase, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Editor.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Editor.Endpoint.config_change(changed, removed)
    :ok
  end
end
