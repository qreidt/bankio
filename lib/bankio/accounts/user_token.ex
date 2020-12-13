defmodule App.Accounts.UserToken do
  use Ecto.Schema

  import Ecto.Changeset

  alias App.Accounts.User
  alias App.Accounts.UserToken

  # @hash_algorithm :sha256
  # @rand_size 32

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "user_tokens" do
    field :revoked, :boolean, default: false
    field :revoked_at, :utc_datetime

    belongs_to :user, User

    timestamps(updated_at: false)
  end

  def changeset(%UserToken{} = user_token, attrs) do
    user_token
    |> cast(attrs, [:token])
    |> validate_required([:token])
    |> unique_constraint(:token)
  end
end
