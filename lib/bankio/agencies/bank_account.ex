defmodule App.Agencies.BankAccount do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "bank_accounts" do
    field :code, :integer
    field :is_active, :boolean, default: false
    field :balance, :decimal
    field :credit, :decimal
    field :since, :utc_datetime
    field :until, :utc_datetime

    belongs_to :agency, App.Agencies.Agency, define_field: :agency_id
    has_many :clients, App.Agencies.BankAccountClient
    has_many :cards, App.Cards.Card

    timestamps()
  end

  @doc false
  def changeset(bank_account, attrs) do
    bank_account
    |> cast(attrs, [:agency_id, :code, :is_active, :balance, :credit, :since, :until])
    |> validate_required([:agency_id, :code, :is_active, :balance, :credit, :since])
    |> unique_constraint(:code)
    |> foreign_key_constraint(:agency_id)
  end

  @doc false
  def update_changeset(bank_account, attrs) do
    bank_account
    |> cast(attrs, [:code, :is_active, :balance, :credit, :since, :until])
    |> validate_required([:agency_id, :code, :is_active, :balance, :credit, :since])
    |> unique_constraint(:code)
    |> foreign_key_constraint(:agency_id)
  end
end
