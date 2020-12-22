defmodule App.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "companies" do
    field :name, :string
    field :document, :string
    field :is_active, :boolean, default: false

    has_many :members, App.Companies.CompanyClient, foreign_key: :company_id
    # many_to_many(
    #   :members,
    #   App.Accounts.Client,
    #   join_through: "company_clients",
    #   join_keys: [company_id: :id, client_id: :id]
    # )

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name, :document, :is_active])
    |> validate_required([:name, :document, :is_active])
  end
end
