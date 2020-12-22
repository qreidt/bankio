defmodule App.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :document, :string, null: false
      add :is_active, :boolean, default: false, null: false

      timestamps type: :utc_datetime
    end

  end
end
