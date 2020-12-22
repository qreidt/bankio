defmodule App.Repo.Migrations.CreateClientTokens do
  use Ecto.Migration

  def change do
    create table(:client_tokens, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :client_id, references(:clients, type: :binary_id, on_delete: :delete_all), null: false
      add :revoked, :boolean, default: false, null: false
      add :revoked_at, :utc_datetime

      timestamps type: :utc_datetime, updated_at: false
    end
  end
end
