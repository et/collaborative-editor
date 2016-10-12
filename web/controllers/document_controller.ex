defmodule Editor.DocumentController do
  use Editor.Web, :controller

  alias Editor.Document
  alias Editor.Repo

  # alias RethinkDatabase, as: DB
  # alias RethinkDB.Query

  def index(conn, _params) do
    documents = Document |> Repo.all
    render conn, "index.html", documents: documents
  end

  def show(conn, %{"id" => id}) do
    document = Repo.get! Document, id
    render conn, "show.html", document: document
  end

  # # Sets up two documents for us to work with
  # def init(conn, _params) do
  #   Query.table_create("documents")
  #   |> DB.run
  #
  #   Query.table("documents") |> Query.insert(%{title: "Document 1"}) |> DB.run
  #   Query.table("documents") |> Query.insert(%{title: "Document 2"}) |> DB.run
  #
  #   text conn, "Documents table create."
  # end
  #
  # def index(conn, _params) do
  #   query = Query.table("documents")
  #
  #   documents = case DB.run(query) do
  #     %RethinkDB.Collection{data: documents} -> documents
  #     _ -> []
  #   end
  #
  #   render(conn, "index.html", documents: documents)
  # end
  #
  # def show(conn, %{"id" => id}) do
  #   query = Query.table("documents")
  #     |> Query.filter(%{id: id})
  #
  #   document = case DB.run(query) do
  #     %RethinkDB.Collection{data: documents} -> List.first documents
  #     _ -> nil
  #   end
  #
  #   render(conn, "show.html", document: document)
  # end

  #def update(conn, %{"id" => id, "document" => document_params}) do
  #  document = DB.get(Document, id)
  #  changeset = Document.changeset(document, document_params)

  #  case DB.update(changeset) do
  #    {:ok, document} ->
  #      conn
  #      |> put_flash(:info, "Document updated successfully.")
  #      |> redirect(to: document_path(conn, :show, document))
  #    {:error, changeset} ->
  #      render(conn, "edit.html", document: document, changeset: changeset)
  #  end
  #end
end
