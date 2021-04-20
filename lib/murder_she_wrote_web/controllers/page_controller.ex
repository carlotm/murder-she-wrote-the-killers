defmodule MurderSheWroteWeb.PageController do
  use MurderSheWroteWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
