defmodule App.Repo.Migrations.CreateBankAccounts do
  use Ecto.Migration

  def change do
    create table(:bank_accounts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :agency_id, references(:agencies, on_delete: :delete_all, type: :binary_id),  null: false
      add :code, :integer, null: false
      add :is_active, :boolean, default: false, null: false
      add :since, :utc_datetime, null: false
      add :until, :utc_datetime

      timestamps type: :utc_datetime
    end

    create unique_index(:bank_accounts, [:code])

  end
end
