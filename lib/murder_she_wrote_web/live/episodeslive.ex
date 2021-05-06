defmodule MurderSheWroteWeb.EpisodesLive do
  use MurderSheWroteWeb, :live_view
  alias MurderSheWrote.Episodes

  def mount(_params, _session, socket) do
    all_episodes = Episodes.list_episodes()

    socket =
      assign(socket,
        q: "",
        selected_seasons: [],
        seasons: Episodes.list_seasons(),
        all: all_episodes,
        filtered: all_episodes,
        killer: nil,
        loading: false
      )

    {:ok, socket}
  end

  def handle_params(%{"seasons" => seasons}, _, socket) do
    send(self(), {:filter, q: socket.assigns.q, selected_seasons: String.split(seasons, "-")})

    socket =
      assign(socket,
        q: socket.assigns.q,
        selected_seasons: String.split(seasons, "-"),
        loading: true
      )

    {:noreply, socket}
  end

  def handle_params(_, _, socket) do
    {:noreply, socket}
  end

  def handle_event("filter", %{"q" => q, "seasons" => seasons}, socket) do
    send(self(), {:filter, q: q, selected_seasons: seasons})
    socket = assign(socket, q: q, selected_seasons: seasons, loading: true)
    seasons = Enum.join(tl(seasons), "|")

    if seasons == "" do
      {:noreply, push_patch(socket, to: "/")}
    else
      {:noreply, push_patch(socket, to: "/seasons/#{seasons}")}
    end
  end

  def handle_event("reveal", %{"value" => episode_id}, socket) do
    killer = Episodes.killer_by_episode(episode_id)
    socket = assign(socket, killer: killer)
    {:noreply, socket}
  end

  def handle_event("unreveal", _, socket) do
    socket = assign(socket, killer: nil)
    {:noreply, socket}
  end

  def handle_info({:filter, filters}, socket) do
    results = Episodes.filter_episodes(socket.assigns.all, filters)
    socket = assign(socket, filtered: results, loading: false)
    {:noreply, socket}
  end
end
