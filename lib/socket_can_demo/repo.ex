defmodule SocketCanDemo.Repo do
  use Ecto.Repo,
    otp_app: :socket_can_demo,
    adapter: Ecto.Adapters.SQLite3
end
