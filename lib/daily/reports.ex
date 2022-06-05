defmodule Daily.Reports do
  @moduledoc """
  Report daily information
  """

  alias Daily.Tasks
  alias Daily.Weather

  @spec daily_report() :: %{weather: String.t(), task_descriptions: [String.t()]}
  def daily_report do
    %{weather: weather} = Weather.get_current_weather()
    tasks = Tasks.list_tasks()

    %{
      weather: weather,
      task_descriptions: Enum.map(tasks, & &1.description)
    }
  end
end
