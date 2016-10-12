defmodule Editor.DocumentChannel do
  use Editor.Web, :channel
  alias Editor.Presence
  alias Editor.DocumentView
  alias RethinkDatabase, as: DB
  alias RethinkDB.Query

  def join("documents:" <> document_id, _params, socket) do
    send self(), :after_join
    {:ok, %{}, assign(socket, :document_id, document_id )}
  end

  def handle_info(:after_join, socket) do
    Presence.track(socket, socket.assigns.user, %{
      online_at: :os.system_time(:milli_seconds)
    })
    push socket, "presence_state", Presence.list(socket)
    {:noreply, socket}
  end

  def handle_in(event, params, socket) do
    user = socket.assigns.user
    handle_in(event, params, user, socket)
  end

  def handle_in("document_update", %{"content" => content}, user, socket) do
    document_id = socket.assigns.document_id
    document = %{id: document_id, content: content, updated_by: user}

    query = Query.table("documents")
      |> Query.filter(%{id: document_id})
      |> Query.update(%{content: content})

    case DB.run(query) do
      %RethinkDB.Record{} ->
        broadcast_document_update(socket, document)
        {:reply, :ok, socket}
    end
  end

  def broadcast_document_update(socket, document) do
    rendered_document = Phoenix.View.render(
      DocumentView, "document_update.json", %{
        document: document
      }
    )
    broadcast! socket, "document_update", rendered_document
  end
end
