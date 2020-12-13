defmodule App.Repo.Migrations.CreateUserTokens do
  use Ecto.Migration

  def change do
    create table(:user_tokens, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false
      add :revoked, :boolean, default: false, null: false
      add :revoked_at, :timestamp

      timestamps(updated_at: false)
    end
  end
end
