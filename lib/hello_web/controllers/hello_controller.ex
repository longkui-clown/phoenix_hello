defmodule HelloWeb.HelloController do
  use HelloWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
    # render(conn, :index)  # 将根据accept表头选择是index.html 还是 index.json
  end

  def show(conn, %{"messager" => messager}) do
    IO.inspect messager
    render(conn, "show.html", messager: messager)
  end
end