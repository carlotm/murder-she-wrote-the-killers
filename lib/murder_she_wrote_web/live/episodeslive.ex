defmodule MurderSheWroteWeb.EpisodesLive do
  use MurderSheWroteWeb, :live_view
  alias MurderSheWrote.Episodes
  alias MurderSheWroteWeb.Filters

  def mount(_params, _session, socket) do
    all_episodes = Episodes.list_episodes()

    socket =
      assign(socket,
        filters: [q: "", seasons: []],
        seasons: Episodes.list_seasons(),
        all: all_episodes,
        filtered: all_episodes,
        killer: nil,
        loading: false
      )

    {:ok, socket}
  end

  def handle_params(%{"q" => q, "seasons" => seasons}, _, socket) do
    filters = [q: q, seasons: String.split(seasons, ",")]
    send(self(), {:filter, filters})
    {:noreply, assign(socket, filters: filters, loading: true)}
  end

  def handle_params(_, _, socket), do: {:noreply, socket}

  def handle_event("filter", %{"q" => "", "seasons" => ""}, socket) do
    {:noreply, push_patch(socket, to: "/")}
  end

  def handle_event("filter", %{"q" => q, "seasons" => seasons}, socket) do
    filters = [q: q, seasons: seasons]
    send(self(), {:filter, filters})
    socket = assign(socket, filters: filters, loading: true)
    {:noreply, push_patch(socket, to: "/episodes?q=#{q}&seasons=#{Enum.join(tl(seasons), ",")}")}
  end

  def handle_event("reveal", %{"value" => episode_id}, socket) do
    killer = Episodes.killer_by_episode(episode_id)
    {:noreply, assign(socket, killer: killer)}
  end

  def handle_event("unreveal", _, socket), do: {:noreply, assign(socket, killer: nil)}

  def handle_info({:filter, filters}, socket) do
    {:noreply,
     assign(socket,
       filtered: Episodes.filter_episodes(socket.assigns.all, filters),
       loading: false
     )}
  end
end
