# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :editor,
  ecto_repos: [Editor.Repo]

# Configures the endpoint
config :editor, Editor.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bJFfS6Hxg3dPijn7BpmOzyG5BKsmdViRIoReXk0XEK2nH0t+GT9V4kZDXXp9ySGK",
  render_errors: [view: Editor.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Editor.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
