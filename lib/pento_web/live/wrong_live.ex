defmodule PentoWeb.WrongLive do
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}

  def mount(_params, _session, socket) do
    {:ok, assign(socket, score: 0, message: "Make Your Guess:", time: time())}
  end

  def render(assigns) do ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
      It's <%= @time %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number= {n} ><%= n %></a>
      <% end %>
    </h2>
    """
  end

  def time() do
    DateTime.utc_now |> to_string
  end

  def handle_event("guess", %{"number" => guess}= data, socket) do
    message = "Your Guess: #{guess}. Wrong. Guess again. "
    time = time()
    score = socket.assigns.score - 1
    {
      :noreply,
      assign(
        socket,
        time: time,
        message: message,
        score: score)}
  end
end
