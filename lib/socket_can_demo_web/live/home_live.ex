defmodule SocketCanDemoWeb.HomeLive do
  use SocketCanDemoWeb, :live_view

  def mount(_params, _sesssion, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>Hello World</div>
    """
  end
end
