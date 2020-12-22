defmodule App.Agencies.Agency do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "agencies" do
    field :code, :integer
    field :is_active, :boolean, default: false
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(agency, attrs) do
    agency
    |> cast(attrs, [:code, :name, :is_active])
    |> validate_required([:code, :name, :is_active])
    |> unique_constraint(:code)
  end
end
