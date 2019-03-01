defmodule HelloWeb.PostFinder do
  @behavior Plug
  import Plug.Conn

  alias Hello.Blog

  def init(opts), do: opts

  def call(conn, _) do
    case get_post(conn.params["id"]) do
      {:ok, post} ->
        assign(conn, :post, post)
      {:error, :notfound} ->
        conn
        |> send_resp(404, "Not found")
        |> halt()   # 如果我们想要在404响应的情况下防止下游插件被处理，我们可以简单地调用Plug.Conn.halt / 1。
    end
  end

  def get_post(id) do
    id != "1111" && {:ok, id} || {:error, :notfound}
  end

end