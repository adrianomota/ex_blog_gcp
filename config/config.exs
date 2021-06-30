# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ex_blog_gcp,
  ecto_repos: [ExBlogGcp.Repo]

# Configures the endpoint
config :ex_blog_gcp, ExBlogGcpWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5rZ6OWCDFA4uz+X4bUnQC+OJt04lA/Rq5nV5qHfgbA4IHOBECyVRrGWz6iwxGfzU",
  render_errors: [view: ExBlogGcpWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ExBlogGcp.PubSub,
  live_view: [signing_salt: "WdSMcU/x"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
