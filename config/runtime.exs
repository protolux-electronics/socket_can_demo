import Config

if config_env() == :prod && config_target() != :host do
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  config :socket_can_demo, SocketCanDemoWeb.Endpoint, secret_key_base: secret_key_base
end
