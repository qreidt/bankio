defmodule App.Agencies.AgencyUser do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "agency_users" do
    field :user_id, :binary_id, primary_key: true
    field :agency_id, :binary_id, primary_key: true
    field :role, :string
    field :since, :utc_datetime
    field :until, :utc_datetime

    belongs_to :agency, App.Agencies.Agency, define_field: false
    belongs_to :user, App.Accounts.User, define_field: false

    timestamps()
  end

  @doc false
  def changeset(agency_user, attrs) do
    agency_user
    |> cast(attrs, [:user_id, :agency_id, :role, :since, :until])
    |> validate_required([:user_id, :agency_id, :role, :since])
    |> unique_constraint([:agency_id, :user_id], name: :PRIMARY, message: "Relation already exists.")
    |> foreign_key_constraint(:agency_id)
    |> foreign_key_constraint(:user_id)
  end

  @doc false
  def update_changeset(agency_user, attrs) do
    agency_user
    |> cast(attrs, [:user_id, :agency_id, :role, :since, :until])
    |> validate_required([:role, :since])
  end
end
