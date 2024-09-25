# This file is responsible for configuring your application and its
# dependencies.
#
# This configuration file is loaded before any dependency and is restricted to
# this project.
import Config

# Enable the Nerves integration with Mix
Application.start(:nerves_bootstrap)

config :socket_can_demo,
  target: Mix.target(),
  env: Mix.env(),
  ecto_repos: [SocketCanDemo.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

# Configures the endpoint
config :socket_can_demo, SocketCanDemoWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: SocketCanDemoWeb.ErrorHTML, json: SocketCanDemoWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: SocketCanDemo.PubSub,
  live_view: [signing_salt: "AldtLIks"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  socket_can_demo: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.3",
  socket_can_demo: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Customize non-Elixir parts of the firmware. See
# https://hexdocs.pm/nerves/advanced-configuration.html for details.

config :nerves, :firmware, rootfs_overlay: "rootfs_overlay", provisioning: :nerves_hub_link

# Set the SOURCE_DATE_EPOCH date for reproducible builds.
# See https://reproducible-builds.org/docs/source-date-epoch/ for more information

config :nerves, source_date_epoch: "1725864179"

# config :nerves_hub_link,
#   host: "devices.nervescloud.com",
#   remote_iex: true,
#   fwup_public_keys: [System.fetch_env!("NH_FWUP_PUBLIC_KEY")],
#   shared_secret: [
#     product_key: System.fetch_env!("NH_KEY"),
#     product_secret: System.fetch_env!("NH_SECRET")
#   ]

if Mix.target() != :host,
  do: import_config("target.exs")

import_config "target/#{Mix.target()}.exs"
import_config "env/#{Mix.env()}.exs"
