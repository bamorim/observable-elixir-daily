defmodule Daily.ReportsTest do
  use Daily.DataCase

  import Daily.TasksFixtures

  describe "daily_report/0" do
    setup :mock_weather_api

    test "returns weather and task desscriptions" do
      %{description: description} = task_fixture()

      assert %{
               weather: "rainy",
               task_descriptions: [^description]
             } = Daily.Reports.daily_report()
    end
  end
end
