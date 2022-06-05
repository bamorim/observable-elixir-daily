# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Daily.Repo.insert!(%Daily.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

if Daily.Repo.aggregate(Daily.Tasks.Task, :count) == 0 do
  Daily.Tasks.create_task(%{description: "Eat"})
  Daily.Tasks.create_task(%{description: "Sleep"})
  Daily.Tasks.create_task(%{description: "Prepare ElixirConf EU 2022 Slides"})
  Daily.Tasks.create_task(%{description: "Repeat"})
end
