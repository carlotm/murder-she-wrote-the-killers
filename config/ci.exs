use Mix.Config

config :murder_she_wrote, MurderSheWrote.Repo,
  username: "postgres",
  password: "postgres"

config :murder_she_wrote, MurderSheWroteWeb.Endpoint,
  http: [port: 4000],
  server: false

config :logger, level: :debug
