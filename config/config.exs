# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :daily,
  ecto_repos: [Daily.Repo],
  weather_service_url: "http://localhost:5000"

# Configures the endpoint
config :daily, DailyWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: DailyWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Daily.PubSub,
  live_view: [signing_salt: "AKOwAFeE"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :daily, Daily.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configures Elixir's Logger
config :logger, :console,
  format: {StructuredLogger, :format},
  metadata: :all,
  level: :info

# Use Jason for JSON parsing in Phoenix
config :phoenix,
  json_library: Jason,
  logger: false

config :tesla, adapter: Tesla.Adapter.Hackney

config :daily, Daily.PromEx,
  disabled: false,
  manual_metrics_start_delay: :no_delay,
  drop_metrics_groups: [],
  grafana: :disabled,
  metrics_server: :disabled

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
