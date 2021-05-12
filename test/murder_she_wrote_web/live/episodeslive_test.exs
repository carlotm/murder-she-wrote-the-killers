defmodule MurderSheWroteWeb.EpisodesLiveTest do
  use MurderSheWroteWeb.ConnCase

  import Phoenix.LiveViewTest

  defp has_episode?(view, season, number), do: assert has_element?(view, ".Episode#s#{season}e#{number}")

  defp has_not_episode?(view, season, number), do: refute has_element?(view, ".Episode#s#{season}e#{number}")

  defp has_episodes_count(view, count) do
    assert(has_element?(view, ".Episode:nth-of-type(#{count})"))
    refute(has_element?(view, ".Episode:nth-of-type(#{count + 1})"))
  end

  test "There is only one element with role=main attribute", %{conn: conn} do
    {:ok, view, _} = live(conn, "/")
    assert(has_element?(view, "[role=main]"))
  end

  test "There is a section for filters with a form", %{conn: conn} do
    {:ok, view, _} = live(conn, "/")
    assert(has_element?(view, "#Filters-form"))
  end

  test "The first episode is rendered", %{conn: conn} do
    {:ok, view, _} = live(conn, "/")
    has_episode?(view, 1, 1)
  end

  test "The last episode is rendered", %{conn: conn} do
    {:ok, view, _} = live(conn, "/")
    has_episode?(view, 12, 24)
  end

  test "Selecting one season, shows only that seasons episodes", %{conn: conn} do
    {:ok, view, _} = live(conn, "/")
    view |> element("#Filters-form") |> render_change(%{"seasons" => ["", "7"]})
    has_not_episode?(view, 1, 1)
    has_not_episode?(view, 8, 1)
    has_episode?(view, 7, 1)
    has_episode?(view, 7, 22)
    has_episodes_count(view, 22)
  end

  test "Selecting two seasons, shows only those seasons episodes", %{conn: conn} do
    {:ok, view, _} = live(conn, "/")
    view |> element("#Filters-form") |> render_change(%{"seasons" => ["", "7", "9"]})
    has_not_episode?(view, 1, 1)
    has_not_episode?(view, 8, 1)
    has_episode?(view, 7, 1)
    has_episode?(view, 7, 22)
    has_episode?(view, 9, 1)
    has_episode?(view, 9, 22)
    has_episodes_count(view, 44)
  end

  test "Filtering by the word 'dead' shows the correct episodes", %{conn: conn} do
    {:ok, view, _} = live(conn, "/")
    view |> element("#Filters-form") |> render_change(%{"q" => "bus"})
    has_episode?(view, 1, 19)
    has_episode?(view, 3, 3)
    has_episodes_count(view, 2)
  end

  test "Filtering by the word 'dead' and select a season are an AND filter", %{conn: conn} do
    {:ok, view, _} = live(conn, "/")
    view |> element("#Filters-form") |> render_change(%{"q" => "bus", "seasons" => ["", "3"]})
    has_not_episode?(view, 1, 19)
    has_episode?(view, 3, 3)
    has_episodes_count(view, 1)
  end

  test "Deselecting seasons shows every single episode", %{conn: conn} do
    {:ok, view, _} = live(conn, "/")
    view |> element("#Filters-form") |> render_change(%{"seasons" => ["", "7", "9"]})
    view |> element("#Filters-form") |> render_change(%{"seasons" => [""]})
    has_episodes_count(view, 264)
  end
end
