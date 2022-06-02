defmodule Daily.Repo do
  use Ecto.Repo,
    otp_app: :daily,
    adapter: Ecto.Adapters.Postgres
end
