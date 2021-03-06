defmodule App.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :key, :string, null: false
      add :name, :string, null: false
      add :password, :string, null: false
      add :type, :integer, null: false
      add :is_active, :boolean, default: false, null: false

      timestamps type: :utc_datetime
    end

    create unique_index(:users, [:key])
  end
end
