# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :firestorm,
  ecto_repos: [Firestorm.Repo]

# Configures the endpoint
config :firestorm, FirestormWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "3DZqSm6+jqYGDMJdLeCkn47IwIlyRWJvlkRSZIVblKj9/BOX8j/sFODJZmPPGZpI",
  render_errors: [view: FirestormWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Firestorm.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :ueberauth, Ueberauth,
  providers: [
    # We don't need any permissions on GitHub as we're just using it as an
    # identity provider, so we'll set an empty default scope.
    github: {Ueberauth.Strategy.Github, [default_scope: ""]}
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("GITHUB_CLIENT_ID"),
  client_secret: System.get_env("GITHUB_CLIENT_SECRET")
  # Configures Elixir's Logger

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
