defmodule Editor.PageController do
  use Editor.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
