defmodule App.Repo.Migrations.CreateCompanyClients do
  use Ecto.Migration

  def change do
    create table(:company_clients, primary_key: false) do
      add :company_id, references(:companies, on_delete: :delete_all, type: :binary_id), primary_key: true
      add :client_id, references(:clients, on_delete: :delete_all, type: :binary_id), primary_key: true
      add :since, :utc_datetime, null: false
      add :until, :utc_datetime
      
      timestamps type: :utc_datetime
    end

    create unique_index(:company_clients, [:company_id, :client_id])
  end
end
