defmodule ChatWeb.RoomLive do
  use ChatWeb, :live_view
  require Logger

  @impl true
  def mount(%{"id" => room_id} = _params, _session, socket) do

    topic = "room:" <> room_id
    ChatWeb.Endpoint.subscribe(topic)

    form = to_form(%{"message" => ""})

    {
      :ok,
      socket
      |> assign(:page_title, "💬 #{room_id}")
      |> assign(:room_id, room_id)
      |> assign(:form, form)
      |> assign(:topic, topic)
      |> assign(:messages, ["Hello, chatties!", "How things are going?"])
    }
  end

  @impl true
  def handle_event("submit_message", %{"message" => message}, socket) do
    Logger.info(message: message)
    ChatWeb.Endpoint.broadcast(socket.assigns.topic, "new-message", message)
    {:noreply, socket}
  end

  @impl true
  def handle_info(%{event: "new-message", payload: message}, socket) do
    Logger.info(payload: message)
    {
      :noreply,
      socket
      |> assign(:messages, socket.assigns.messages ++ [message])
    }
  end
end
