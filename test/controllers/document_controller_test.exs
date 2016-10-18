defmodule Editor.DocumentControllerTest do
  use Editor.ConnCase

  alias Editor.Document
  @valid_attrs %{title: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, document_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing documents"
  end

  test "shows chosen resource", %{conn: conn} do
    document = Repo.insert! %Document{}
    conn = get conn, document_path(conn, :show, document)
    assert html_response(conn, 200) =~ "Show document"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, document_path(conn, :show, -1)
    end
  end
end
