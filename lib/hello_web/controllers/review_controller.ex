defmodule HelloWeb.ReviewController do
  use HelloWeb, :controller

  def index(conn, _params) do
    # IO.inspect conn
    render(conn, "index.html")
  end

end