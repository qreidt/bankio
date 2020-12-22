defmodule App.Accounts.Client do
  use Ecto.Schema
  import Ecto.Changeset

  alias App.Repo

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "clients" do
    field :key, :string
    field :name, :string
    field :password, :string
    field :is_active, :boolean, default: false

    has_many :tokens, App.Accounts.ClientToken
    has_many :companies, App.Companies.CompanyClient

    timestamps()
  end

  def verify_password(key, password) do

    Repo.get_by(App.Accounts.Client, key: key)
    |> Bcrypt.check_pass(password, hash_key: :password)

  end

  @doc false
  def changeset(client, attrs) do
    client
    |> cast(attrs, [:key, :name, :password, :is_active])
    |> validate_required([:key, :name, :password, :is_active])
    |> validate_password
    |> unique_constraint(:key)
    |> put_password_hash
  end

  @doc false
  def update_changeset(client, attrs) do
    client
    |> cast(attrs, [:key, :name, :is_active])
    |> validate_required([:key, :name, :is_active])
    |> unique_constraint(:key)
  end

  defp validate_password(changeset) do
    changeset
    |> validate_length(:password, min: 12, max: 80)
    |> validate_format(:password, ~r/[a-z]/, message: "at least one lower case character")
    |> validate_format(:password, ~r/[A-Z]/, message: "at least one upper case character")
    |> validate_format(:password, ~r/[!?@#$%^&*_0-9]/, message: "at least one digit or punctuation character")
  end

  defp put_password_hash(changeset) do
    case changeset do

      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password, Bcrypt.hash_pwd_salt(password))

      _ ->
        changeset

    end
  end
end
