defmodule MurderSheWroteWeb.Router do
  use MurderSheWroteWeb, :router

  pipeline :browser_live do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {MurderSheWroteWeb.LayoutView, :app}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", MurderSheWroteWeb do
    pipe_through :browser_live
    live("/", EpisodesLive)
    live("/seasons/:seasons", EpisodesLive)
  end
end
