defmodule Daily.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias TelemetryLoggers.PlugLogger

  @impl true
  def start(_type, _args) do
    TelemetryLogger.attach_loggers([
      {PlugLogger, router: DailyWeb.Router}
    ])

    children = [
      # Start the Ecto repository
      Daily.Repo,
      # Start the Telemetry supervisor
      DailyWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Daily.PubSub},
      # Start the Endpoint (http/https)
      DailyWeb.Endpoint
      # Start a worker by calling: Daily.Worker.start_link(arg)
      # {Daily.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Daily.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DailyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
