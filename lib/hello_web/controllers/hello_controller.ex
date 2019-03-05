defmodule HelloWeb.HelloController do
  use HelloWeb, :controller

  plug :assign_welcome_message, "Hi" when action in [:index]
  plug HelloWeb.PostFinder when action in [:show]

  action_fallback HelloWeb.MyFallbackController

  def index(conn, params) do
    conn
    |> put_flash(:info, "Welcone to Phoenix, from hello flash message!")  # put flash message
    |> put_flash(:error, "Let's pretend we have some problem!")
    # |> clear_flash()  # 清空flash message
    # |> put_layout(false)    # 关闭layout
    |> put_layout("admin.html")   # 设置其他的layout
    # |> render("index.html")
    # |> put_resp_content_type("text/xml")   # 设置 HTTP Content-Type
    # |> render("index.xml", content: some_xml_content)   # 需要index.xml.eex文件
    render(conn, :index, messager: params["messager"] || "longlonglonglalala")  # 将根据accept表头选择是index.html 还是 index.json，或者index.text, http://127.0.0.1/hello/?_format=text, http://localhost:4000/?_format=text&message=longlong
  end

  def show(conn, %{"messager" => messager}) do
    IO.inspect messager
    with :authed <- if_authed(messager)       # 返回值匹配不上，将交给 HelloWeb.MyFallbackController 处理
    do
      # text(conn, "just show text : #{messager}")  # 简单返回文本
      # json(conn, %{messager: messager})   # 返回json

      # html(conn, """
      #  <html>
      #    <head>
      #       <title>Passing an Id</title>
      #    </head>
      #    <body>
      #      <p>You sent in id #{messager}</p>
      #    </body>
      #  </html>
      # """)    # render一个简单的网页

      # 上述的都不需要view模块进行渲染

      # render(conn, "show.html", messager: messager)
      # or
      conn
      |> assign(:messager, "lalalalaalalala")
      |> render("show.html")
      # |> put_status(:not_found)     # 或404， 别名参考 https://hexdocs.pm/plug/1.7.0/Plug.Conn.html#put_status/2
      # |> put_view(HelloWeb.ErrorView)
      # |> render("404.html")
    end
  end

  def assign_welcome_message(conn, msg) do
    assign(conn, :message, msg)
  end
  
  def test(conn, _params) do
    conn
    |> put_resp_content_type("text/plain")
    # |> send_resp(201, "")   # 直接返回响应，显示一个空白的网页
    |> redirect(to: "/hello/redirect")
    # |> redirect(external: "https://elixir-lang.org/")
    # |> redirect(to: Routes.redirect_test_url(conn, :redirect_test))
    # |> redirect(external: Routes.redirect_test_url(conn, :redirect_test))
  end

  def test_redirect(conn, _params) do
    IO.inspect "here id applyed"
    text(conn, "just for a test of redirect!!!")
  end

  defp if_authed(mmm) do
    mmm == "1111" && :authed || {:error, :not_found}
  end

  def test_json_one(conn, _params) do
    page = %{title: "foo"}
    conn
    |> render("one.json", page: page) # 有问题，在view里面？？？？？？？？？
  end

  def test_json_many(conn, _params) do
    pages = [%{title: "foo"}, %{title: "bar"}]
    conn
    |> render("many.json", pages: pages)  # 有问题，在view里面？？？？？？？？？
  end

end