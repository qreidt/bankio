defmodule App.Repo.Migrations.CreateCreditInvoices do
  use Ecto.Migration

  def change do
    create table(:credit_invoices, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :card_id, references(:cards, on_delete: :delete_all, type: :binary_id), null: false
      add :balance, :decimal, null: false
      add :reference_month, :string, null: false
      add :status, :integer, null: false
      add :started, :utc_datetime, null: false
      add :ended, :utc_datetime, null: false
      add :paid_at, :utc_datetime
      add :interest, :decimal, null: false

      timestamps type: :utc_datetime
    end

  end
end
