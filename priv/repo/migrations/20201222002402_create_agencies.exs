defmodule App.Repo.Migrations.CreateAgencies do
  use Ecto.Migration

  def change do
    create table(:agencies, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :code, :integer, null: false
      add :name, :string, null: false
      add :is_active, :boolean, default: false, null: false

      timestamps type: :utc_datetime
    end

    create unique_index(:agencies, [:code])
  end
end
