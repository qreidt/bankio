defmodule App.Accounts.ClientToken do
  use Ecto.Schema

  import Ecto.Changeset

  alias App.Accounts.Client
  alias App.Accounts.ClientToken

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "client_tokens" do
    field :revoked, :boolean, default: false
    field :revoked_at, :utc_datetime

    belongs_to :client, Client

    timestamps(updated_at: false)
  end

  def changeset(%ClientToken{} = user_token, attrs) do
    user_token
    |> cast(attrs, [:token])
    |> validate_required([:token])
    |> unique_constraint(:token)
  end
end
