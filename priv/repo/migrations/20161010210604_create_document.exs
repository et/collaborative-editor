defmodule Editor.Repo.Migrations.CreateDocument do
  use Ecto.Migration

  def change do
    create table(:documents) do
      add :title, :string
      add :content, :text

      timestamps()
    end

  end
end
