defmodule App.Cards.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "transactions" do
    field :value, :decimal
    field :execute_at, :utc_datetime
    field :executed, :boolean, default: false

    belongs_to :credit_invoice, App.Cards.CreditInvoice, define_field: :credit_invoice_id
    belongs_to :card, App.Cards.Card, define_field: :card_id

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:credit_invoice_id, :card_id, :value, :executed, :execute_at])
    |> validate_required([:card_id, :value, :executed])
    |> foreign_key_constraint(:credit_invoice_id)
    |> foreign_key_constraint(:card_id)
  end

  @doc false
  def update_changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:value, :executed, :execute_at])
    |> validate_required([:value, :executed])
  end
end
