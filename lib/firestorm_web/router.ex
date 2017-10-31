defmodule FirestormWeb.Router do
  use FirestormWeb, :router

  pipeline :browser do
    plug Ueberauth
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FirestormWeb do
    pipe_through :api
  end

  scope "/", FirestormWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    resources "/categories", CategoryController do
      resources "/threads", ThreadController
    end
  end

  scope "/auth", FirestormWeb.Web do
    pipe_through :browser

    delete "/logout", AuthController, :delete
    get "/logout", AuthController, :delete
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", FirestormWeb do
  #   pipe_through :api
  # end
end
