defmodule MurderSheWrote.Repo do
  use Ecto.Repo,
    otp_app: :murder_she_wrote,
    adapter: Ecto.Adapters.Postgres
end
