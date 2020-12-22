defmodule App.Companies.CompanyClient do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "company_clients" do
    field :company_id, :binary_id, primary_key: true
    field :client_id, :binary_id, primary_key: true

    field :since, :utc_datetime
    field :until, :utc_datetime

    belongs_to :company, App.Companies.Company, define_field: false
    belongs_to :client, App.Accounts.Client, define_field: false

    timestamps
  end

  @doc false
  def changeset(company_client, attrs) do
    company_client
    |> cast(attrs, [:company_id, :client_id, :since, :until])
    |> validate_required([:company_id, :client_id, :since])
    |> unique_constraint([:company_id, :client_id], name: :PRIMARY, message: "Relation already exists.")
    |> foreign_key_constraint(:company_id)
    |> foreign_key_constraint(:client_id)
  end

  @doc false
  def update_changeset(company_client, attrs) do
    company_client
    |> cast(attrs, [:since, :until])
    |> validate_required([:company_id, :client_id])
  end
end
