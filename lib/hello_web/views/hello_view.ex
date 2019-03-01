defmodule HelloWeb.HelloView do
  use HelloWeb, :view
  
  # 实际上，Phoenix中的“templates”实际上只是其视图模块上的函数定义。替换下面函数，将输出下面的字符串
  # 在编译时，Phoenix预编译所有* .html.eex模板，并将它们转换为各自视图模块上的render / 2函数子句。在运行时，所有模板都已加载到内存中。
  # 没有涉及磁盘读取，复杂文件缓存或模板引擎计算。这也是我们能够在LayoutView中定义title / 0等函数的原因，并且它们在布局的app.html.eex中立即可用 - 对title / 0的调用只是一个本地函数调用！
  # def render("index.html", assigns) do
  #   "rendering with assigns #{inspect Map.keys(assigns)}"
  # end
  
  def render("one.json",  %{page: page}) do
    # IO.inspect page 
    # render_one(page, __MODULE__, "one.json")        # 有问题，暂时不管 ？？？？？？？？？？？？？？
    %{data: page}
  end

  def render("many.json", %{pages: pages}) do
    # render_many(pages,HelloWeb.HelloView, "many.json")
    %{data: pages}
  end

  def message do
    "Hello from the view!"
  end

end