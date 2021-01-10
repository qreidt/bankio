defmodule App.Cards.Card do
  use Ecto.Schema
  import Ecto.Changeset

  alias App.Repo

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "cards" do
    field :password, :string
    field :code, :integer
    field :is_active, :boolean, default: false

    belongs_to :bank_account, App.Agencies.Agency, define_field: :bank_account_id

    timestamps()
  end

  def verify_password(code, password) do
    Repo.get_by(App.Cards.Card, code: code)
    |> Bcrypt.check_pass(password, hash_key: :password)
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:bank_account_id, :code, :password, :is_active])
    |> validate_required([:bank_account_id, :code, :password, :is_active])
    |> foreign_key_constraint(:bank_account_id)
    |> unique_constraint(:code)
    |> validate_password
    |> put_password_hash
  end

  @doc false
  def update_changeset(card, attrs) do
    card
    |> cast(attrs, [:code, :password, :is_active])
    |> validate_required([:code, :password, :is_active])
  end

  defp validate_password(changeset) do
    changeset
    |> validate_length(:password, min: 4, max: 80)
    |> validate_format(:password, ~r/[0-9]/, message: "at least one lower case character")
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
