defmodule DailyWeb.ReportController do
  use DailyWeb, :controller

  alias Daily.Reports

  action_fallback DailyWeb.FallbackController

  def daily(conn, _params) do
    report = Reports.daily_report()
    render(conn, "daily.json", report: report)
  end
end
