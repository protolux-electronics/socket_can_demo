defmodule SocketCanDemo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SocketCanDemo.Supervisor]

    children =
      [
        SocketCanDemoWeb.Telemetry,
        SocketCanDemo.Repo,
        {Ecto.Migrator,
         repos: Application.fetch_env!(:socket_can_demo, :ecto_repos), skip: skip_migrations?()},
        {Phoenix.PubSub, name: SocketCanDemo.PubSub},
        SocketCanDemoWeb.Endpoint
      ] ++ children(target())

    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SocketCanDemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  # List all child processes to be supervised
  def children(:host) do
    []
  end

  def children(_target) do
    [
      {SocketCAN, name: SocketCanDemo.SocketCAN, interface: "can0"}
    ]
  end

  def target() do
    Application.get_env(:socket_can_demo, :target)
  end

  defp skip_migrations?() do
    # By default, sqlite migrations are run when using a release
    System.get_env("RELEASE_NAME") != nil
  end
end
