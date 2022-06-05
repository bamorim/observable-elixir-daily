defmodule DailyWeb.ReportControllerTest do
  use DailyWeb.ConnCase

  setup :mock_weather_api

  describe "daily" do
    test "lists all tasks", %{conn: conn} do
      conn = get(conn, Routes.report_path(conn, :daily))
      assert json_response(conn, 200)["weather"] == "rainy"
      assert json_response(conn, 200)["task_descriptions"] == []
    end
  end
end
