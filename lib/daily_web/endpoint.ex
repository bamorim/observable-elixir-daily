defmodule DailyWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :daily

  plug PromEx.Plug, prom_ex_module: Daily.PromEx

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_daily_key",
    signing_salt: "dcu9A3jm"
  ]

  socket "/live", Phoenix.LiveView.Socket, websocket: [connect_info: [session: @session_options]]

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :daily,
    gzip: false,
    only: ~w(assets fonts images favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :daily
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options

  plug :set_logger_trace_id

  def set_logger_trace_id(conn, _opts) do
    span_ctx = OpenTelemetry.Tracer.current_span_ctx()

    if span_ctx != :undefined do
      Logger.metadata(trace_id: OpenTelemetry.Span.hex_trace_id(span_ctx))
    end

    conn
  end

  plug DailyWeb.Router
end
