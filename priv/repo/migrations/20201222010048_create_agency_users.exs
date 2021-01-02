defmodule App.Repo.Migrations.CreateAgencyUsers do
  use Ecto.Migration

  def change do
    create table(:agency_users, primary_key: false) do
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id), primary_key: true
      add :agency_id, references(:agencies, on_delete: :delete_all, type: :binary_id), primary_key: true
      add :role, :string, null: false
      add :since, :utc_datetime, null: false
      add :until, :utc_datetime
      
      timestamps type: :utc_datetime
    end

    create unique_index(:agency_users, [:user_id, :agency_id])

  end
end
