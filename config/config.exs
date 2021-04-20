# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :murder_she_wrote,
  ecto_repos: [MurderSheWrote.Repo]

# Configures the endpoint
config :murder_she_wrote, MurderSheWroteWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "h+C7EZYaOUH+IhmpPdsiTYc4p8MBYKsFrJIqqJnv8CKlw0vGtsQux1YlNJ99nyN1",
  render_errors: [view: MurderSheWroteWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: MurderSheWrote.PubSub,
  live_view: [signing_salt: "qb3RnLr4"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
