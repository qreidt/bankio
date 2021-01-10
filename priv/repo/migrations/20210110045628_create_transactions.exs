defmodule App.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :credit_invoice_id, references(:credit_invoices, on_delete: :delete_all, type: :binary_id), null: true
      add :card_id, references(:cards, on_delete: :delete_all, type: :binary_id), null: false
      add :value, :decimal, null: false, precision: 18, scale: 5
      add :executed, :boolean, default: false, null: false
      add :execute_at, :utc_datetime

      timestamps type: :utc_datetime
    end

  end
end
