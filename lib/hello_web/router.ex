defmodule HelloWeb.Router do
  use HelloWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HelloWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/hello", HelloController, :index
    get "/hello/:messager", HelloController, :show
    resources "/users", UserController
    # resources "/posts_only", PostController, only: [:index, :show]
    # resources "/posts_except", PostController, except: [:show]

    resources "/users", UserController do
      resources "/posts", PostController    # 允许嵌套resources, HelloWeb.Router.Helpers.user_post_path(HelloWeb.Endpoint, :show, 1, 1), "/users/1/posts/1"
    end
  end

  forward "/jobs", BackgroundJob.Plug # 这意味着以/ jobs开头的所有路由都将被发送到BackgroundJob.Plug模块。

  # Other scopes may use custom stacks.
  # scope "/api", HelloWeb do
  #   pipe_through :api
  # end
end
