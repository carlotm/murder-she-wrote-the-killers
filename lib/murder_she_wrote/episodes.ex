defmodule MurderSheWrote.Episodes do
  import Ecto.Query, only: [from: 2]

  alias MurderSheWrote.Repo
  alias MurderSheWrote.Episodes.Episode
  alias MurderSheWrote.Episodes.Season
  alias MurderSheWrote.Episodes.Killer

  def list_episodes do
    query = from e in Episode, order_by: [e.season_id, e.number], preload: [:season]
    Repo.all(query)
  end

  def list_seasons do
    query = from s in Season, order_by: [s.number]
    Repo.all(query)
  end

  def filter_episodes(episodes, q: q, seasons: seasons) do
    episodes
    |> filter_by_title(q)
    |> filter_by_seasons(seasons)
  end

  defp filter_by_title(episodes, q) do
    cleaned_title = q |> String.trim() |> String.downcase()
    Enum.filter(episodes, fn episode -> String.downcase(episode.title) =~ cleaned_title end)
  end

  defp filter_by_seasons(episodes, [""]), do: episodes

  defp filter_by_seasons(episodes, seasons) when is_list(seasons) do
    Enum.filter(episodes, fn episode -> "#{episode.season.number}" in seasons end)
  end

  def killer_by_episode(eid) do
    query =
      from k in Killer, join: e in Episode, on: k.episode_id == e.id, where: k.episode_id == ^eid

    Repo.one(query)
  end
end
