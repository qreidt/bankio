defmodule App.Repo.Migrations.CreateBankAccountClients do
  use Ecto.Migration

  def change do
    create table(:bank_account_clients, primary_key: false) do
      add :client_id, references(:clients, on_delete: :delete_all, type: :binary_id), primary_key: true
      add :bank_account_id, references(:bank_accounts, on_delete: :delete_all, type: :binary_id), primary_key: true
      add :since, :utc_datetime, null: false
      add :until, :utc_datetime

      timestamps type: :utc_datetime
    end

    create unique_index(:bank_account_clients, [:client_id, :bank_account_id])

  end
end
