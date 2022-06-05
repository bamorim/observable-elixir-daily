defmodule DailyWeb.ReportView do
  use DailyWeb, :view

  def render("daily.json", %{report: %{weather: weather, task_descriptions: tasks}}) do
    %{weather: weather, task_descriptions: tasks}
  end
end
