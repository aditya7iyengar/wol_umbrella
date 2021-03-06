defmodule WolWeb.Router do
  use WolWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug BasicAuth, use_config: {:wol_web, :http_basic_config}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WolWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/about", PageController, :about
    get "/first_select/", PageController, :first_select
    get "/second_select/", PageController, :second_select
    get "/generate_pairs/", PageController, :generate_pairs
    get "/pair_generator/", PageController, :pair_generator

    resources "/people", PersonController
    resources "/pair_iterations", PairIterationController
  end
end
