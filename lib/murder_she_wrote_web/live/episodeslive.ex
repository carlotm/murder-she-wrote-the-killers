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
    seasons = seasons |> String.split(",") |> Enum.map(&String.to_integer(&1))
    send(self(), {:filter, q: "", selected_seasons: seasons})
    socket = assign(socket, q: "", selected_seasons: seasons, loading: true)
    {:noreply, socket}
  end

  def handle_params(_, _, socket) do
    {:noreply, socket}
  end

  def handle_event("filter", %{"q" => q, "seasons" => seasons}, socket) do
    send(self(), {:filter, q: q, selected_seasons: seasons})
    socket = assign(socket, q: q, selected_seasons: seasons, loading: true)
    {:noreply, socket}
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
    IO.inspect(socket.assigns.all)
    results = Episodes.filter_episodes(socket.assigns.all, filters)
    socket = assign(socket, filtered: results, loading: false)
    {:noreply, socket}
  end
end
