defmodule MurderSheWroteWeb.EpisodesLiveTest do
  use MurderSheWroteWeb.ConnCase

  import Phoenix.LiveViewTest

  test "There is only one element with role=main attribute", %{conn: conn} do
    {:ok, view, _} = live(conn, "/")
    assert(has_element?(view, "[role=main]"))
  end

  test "There is a section for filters with a form", %{conn: conn} do
    {:ok, view, _} = live(conn, "/")
    assert(has_element?(view, "section.Filters > form"))
  end

  test "The first episode is rendered", %{conn: conn} do
    {:ok, view, _} = live(conn, "/")
    assert(has_element?(view, "article#s1e1"))
  end

  test "The last episode is rendered", %{conn: conn} do
    {:ok, view, _} = live(conn, "/")
    assert(has_element?(view, "article#s12e24"))
  end
end
