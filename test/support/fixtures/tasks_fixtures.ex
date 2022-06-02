defmodule Daily.TasksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Daily.Tasks` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        description: "some description"
      })
      |> Daily.Tasks.create_task()

    task
  end
end
