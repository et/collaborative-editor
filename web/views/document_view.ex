defmodule Editor.DocumentView do
  use Editor.Web, :view

  def render("document.json", %{document: document}) do
    %{
      id: document["id"],
      content: document["content"]
    }
  end


  def render("document_update.json", %{document: document}) do
    %{
      id: document.id,
      content: document.content,
      updated_by: document.updated_by
    }
  end
end
