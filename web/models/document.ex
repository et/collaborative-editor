defmodule Editor.Document do
  use Editor.Web, :model

  @required_fields ~w(title content user)
  @optional_fields ~w()

  schema "documents" do
    field :title, :string
    field :content, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end

  def as_struct(document) do
    %__MODULE__{
      content: document["content"],
      title: document["title"],
      id: document["id"]
    }
  end
end
