defmodule App.Agencies.BankAccountClient do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "bank_account_clients" do
    field :client_id, :binary_id, primary_key: true
    field :bank_account_id, :binary_id, primary_key: true
    field :since, :utc_datetime
    field :until, :utc_datetime

    belongs_to :client, App.Accounts.Client, define_field: false
    belongs_to :bank_account, App.Agencies.BankAccount, define_field: false

    timestamps()
  end

  @doc false
  def changeset(bank_account_client, attrs) do
    bank_account_client
    |> cast(attrs, [:client_id, :bank_account_id, :since, :until])
    |> validate_required([:client_id, :bank_account_id, :since])
    |> unique_constraint([:client_id, :bank_account_id], name: :PRIMARY, message: "Relation already exists.")
    |> foreign_key_constraint(:client_id)
    |> foreign_key_constraint(:bank_account_id)
  end

  @doc false
  def update_changeset(bank_account_client, attrs) do
    bank_account_client
    |> cast(attrs, [:client_id, :bank_account_id, :since, :until])
    |> validate_required([:since])
  end
end
