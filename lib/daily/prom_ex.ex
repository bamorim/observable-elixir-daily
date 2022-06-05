defmodule Daily.PromEx do
  @moduledoc """
  PromEx configuration for prometheus metrics and grafana dashboards
  """

  use PromEx, otp_app: :daily

  alias PromEx.Plugins

  @impl true
  def plugins do
    [
      Plugins.Application,
      Plugins.Beam,
      {Plugins.Phoenix, router: DailyWeb.Router, endpoint: DailyWeb.Endpoint},
      Plugins.Ecto
    ]
  end

  @impl true
  def dashboard_assigns do
    [
      datasource_id: "prometheus",
      default_selected_interval: "30s"
    ]
  end

  @impl true
  def dashboards do
    [
      {:prom_ex, "application.json"},
      {:prom_ex, "beam.json"},
      {:prom_ex, "phoenix.json"},
      {:prom_ex, "ecto.json"}
    ]
  end
end
