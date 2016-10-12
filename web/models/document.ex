defmodule Editor.Document do
  use Editor.Web, :model

  @required_fields ~w(title)
  @optional_fields ~w(content)

  schema "documents" do
    field :title, :string
    field :content, :string
    field :last_updated_by, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :content, :last_updated_by])
    |> validate_required([:title])
  end
end
