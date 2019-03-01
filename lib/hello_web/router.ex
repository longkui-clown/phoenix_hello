defmodule HelloWeb.Router do
  use HelloWeb, :router

  pipeline :browser do
    plug :accepts, ["html", "text", "json"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  def put_headers(conn, key_values) do
    Enum.reduce key_values, conn, fn {k, v}, conn ->
      Plug.Conn.put_resp_header(conn, to_string(k), v)
    end
  end

  pipeline :review_check do
    plug :put_headers, %{content_encoding: "gzip", cache_control: "max-age=3600", longkui: "12134"}
    # plug :ensure_authenticated_user
    # plug :ensure_user_owns_review
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HelloWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/hello", HelloController, :index
    get "/hello/test", HelloController, :test
    get "/hello/redirect", HelloController, :test_redirect, as: :test_redirect
    get "/hello/test_json/one.json", HelloController, :test_json_one
    get "/hello/test_json/many.json", HelloController, :test_json_many
    get "/hello/:messager", HelloController, :show
    resources "/users", UserController
    # resources "/posts_only", PostController, only: [:index, :show]
    # resources "/posts_except", PostController, except: [:show]

    # resources "/users", UserController do
    #   resources "/posts", PostController    # 允许嵌套resources, HelloWeb.Router.Helpers.user_post_path(HelloWeb.Endpoint, :show, 1, 1), "/users/1/posts/1"
    # end
    get "/message/:id", MessageController, :show
  end

  scope "/reviews", HelloWeb do
    pipe_through [:browser, :review_check]

    resources "/", ReviewController
  end

  scope "/admins", HelloWeb.Admin, as: :admin do    # scope 技术上支持嵌套，但是不建议使用，因为会使得代码混乱
    pipe_through :browser

    resources "/reviews", ReviewController
    # resources "/lalas", LalaController, only: [:index]
    resources "/images",  ImageController
    resources "/users",   UserController
  end

  scope "/api", HelloWeb.Api, as: :api do
    pipe_through :api

    resources "/reviews", ReviewController
  end

  forward "/jobs", BackgroundJob.Plug # 这意味着以/ jobs开头的所有路由都将被发送到BackgroundJob.Plug模块。

  # Other scopes may use custom stacks.
  # scope "/api", HelloWeb do
  #   pipe_through :api
  # end
end
