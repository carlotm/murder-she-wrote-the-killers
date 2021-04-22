defmodule MurderSheWroteWeb.PageController do
  use MurderSheWroteWeb, :controller

  def index(conn, _params) do
    episodes = MurderSheWrote.Episodes.list_episodes()
    render(conn, "index.html", episodes: episodes)
  end
end
