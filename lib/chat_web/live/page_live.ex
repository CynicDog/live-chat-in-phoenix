defmodule ChatWeb.PageLive do
  use ChatWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_event("random-room", _params, socket) do
    IO.puts("Button clicked: random-room")
    {:noreply, socket}
  end
end
