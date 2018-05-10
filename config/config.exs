# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :library_api,
  ecto_repos: [LibraryApi.Repo],
  jwt_secret: System.get_env("JWT_SECRET") || "dyMqQgU1HQLDUQjyCxhjbMom56S7JLQDX8ZmfF/yJ/HqyllEzUxBlIxItSwouMzh"

# Configures the endpoint
config :library_api, LibraryApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "AbUCYV5ClOYXouI2J3N0CVuj7qXb18hKDOXpJvHGMy55b33+ZOrA+IqKregTKT41",
  render_errors: [view: LibraryApiWeb.ErrorView, accepts: ~w(json json-api)],
  pubsub: [name: LibraryApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :mime, :types, %{
  "application/vnd.api+json" => ["json-api"]
}

config :phoenix, :format_encoders, "json-api": Poison

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
