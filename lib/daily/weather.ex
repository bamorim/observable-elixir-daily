defmodule Daily.Weather do
  @moduledoc """
  Proxy for the Weather Service
  """

  @spec get_current_weather() :: %{weather: String.t()}
  def get_current_weather do
    case Tesla.get(client(), "/api/weather") do
      {:ok, %{status: 200, body: %{"weather" => weather}}} ->
        %{weather: weather}

      _ ->
        raise "Invalid response from service"
    end
  end

  defp client do
    Tesla.client([
      {Tesla.Middleware.BaseUrl, base_url()},
      Tesla.Middleware.JSON,
      Tesla.Middleware.Telemetry,
      Tesla.Middleware.OpenTelemetry,
      {Tesla.Middleware.Logger, log_level: :debug}
    ])
  end

  defp base_url do
    Application.get_env(:daily, :weather_service_url)
  end
end
