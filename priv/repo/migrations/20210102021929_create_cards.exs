defmodule App.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do
    create table(:cards, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :bank_account_id, references(:bank_accounts, on_delete: :delete_all, type: :binary_id), null: false
      add :code, :integer, null: false
      add :password, :string, null: false
      add :is_active, :boolean, default: false, null: false

      timestamps type: :utc_datetime
    end

    create unique_index(:cards, [:code])
  end
end
