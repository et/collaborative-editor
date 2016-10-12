defmodule Editor.Repo.Migrations.CreateDocument do
  use Ecto.Migration

  def change do
    create table(:documents) do
      add :title, :string
      add :content, :text
      add :last_updated_by, :string

      timestamps()
    end

  end
end
