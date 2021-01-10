defmodule App.Cards.CreditInvoice do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "credit_invoices" do
    field :balance, :decimal
    field :reference_month, :string
    field :status, :integer
    field :started, :utc_datetime
    field :ended, :utc_datetime
    field :paid_at, :utc_datetime
    field :interest, :decimal

    belongs_to :card, App.Cards.Card, define_field: :card_id

    timestamps()
  end

  def status do
    %{
      OPEN: 1,
      CLOSED: 2,
      OVERDUE: 3
    }
  end

  @doc false
  def changeset(credit_invoice, attrs) do
    credit_invoice
    |> cast(attrs, [:card_id, :balance, :reference_month, :status, :started, :ended, :paid_at, :interest])
    |> validate_required([:card_id, :balance, :reference_month, :status, :started, :ended, :interest])
    |> foreign_key_constraint(:card_id)
  end

  @doc false
  def update_changeset(credit_invoice, attrs) do
    credit_invoice
    |> cast(attrs, [:balance, :reference_month, :status, :started, :ended, :paid_at, :interest])
    |> validate_required([:balance, :reference_month, :status, :started, :ended, :interest])
  end
end
