defmodule App.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false

  alias App.Accounts
  alias App.Accounts.{User, Client}

  alias App.Repo
  alias App.Services.Authenticator

  #############################
  #
  # Users
  #
  #############################

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)
  def get_user!(id, :complete) do
    base_query = from user in User, where: user.id == ^id

    base_query
    |> Accounts.preload_agencies
    |> Repo.one!
  end

  def preload_agencies(query) do
    from user in query,
      left_join: agency_user in assoc(user, :agencies),
      left_join: agency in assoc(agency_user, :agency),
      preload: [agencies: {agency_user, agency: agency}]
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end


  #############################
  #
  # Clients
  #
  #############################


  @doc """
  Returns the list of clients.

  ## Examples

      iex> list_clients()
      [%Client{}, ...]

  """
  def list_clients do
    Repo.all(Client)
  end

  @doc """
  Gets a single client.

  Raises `Ecto.NoResultsError` if the Client does not exist.

  ## Examples

      iex> get_client!(123)
      %Client{}

      iex> get_client!(456)
      ** (Ecto.NoResultsError)

  """
  def get_client!(id), do: Repo.get!(Client, id)
  def get_client!(id, :complete) do
    base_query = from client in Client, where: client.id == ^id

    base_query
    |> Accounts.preload_companies
    |> Repo.one!
  end

  def preload_companies(query) do
    from client in query,
      left_join: c in assoc(client, :companies),
      left_join: company in assoc(c, :company),
      preload: [companies: {c, company: company}]
  end

  @doc """
  Creates a client.

  ## Examples

      iex> create_client(%{field: value})
      {:ok, %Client{}}

      iex> create_client(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_client(attrs \\ %{}) do
    %Client{}
    |> Client.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a client.

  ## Examples

      iex> update_client(client, %{field: new_value})
      {:ok, %Client{}}

      iex> update_client(client, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_client(%Client{} = client, attrs) do
    client
    |> Client.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a client.

  ## Examples

      iex> delete_client(client)
      {:ok, %Client{}}

      iex> delete_client(client)
      {:error, %Ecto.Changeset{}}

  """
  def delete_client(%Client{} = client) do
    Repo.delete(client)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking client changes.

  ## Examples

      iex> change_client(client)
      %Ecto.Changeset{data: %Client{}}

  """
  def change_client(%Client{} = client, attrs \\ %{}) do
    Client.changeset(client, attrs)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end


  def login(:user, key, password) do
    login_account("user", key, password)
  end

  def login(:client, key, password) do
    login_account("client", key, password)
  end

  defp login_account(namespace, key, password) do

    case namespace do

      "user" ->

        case User.verify_password(key, password) do

          {:ok, user} ->
            token = Authenticator.generate_token(namespace, user)
            {:ok, user, token}

          error -> error

        end

      # end "user" case

      "client" ->

        case Client.verify_password(key, password) do

          {:ok, user} ->
            token = Authenticator.generate_token(namespace, user)
            {:ok, user, token}

          error -> error

        end

      # end "client" case

    end
  end


  def logout(:user, conn) do
    logout_account("user", conn)
  end

  def logout(:client, conn) do
    logout_account("client", conn)
  end

  defp logout_account(namespace, conn) do

    case Authenticator.get_token(namespace, conn) do

      {:ok, token} ->

        case namespace do

          "user" ->

            case Repo.get(App.Accounts.UserToken, token) do

              nil -> {:error, "Not Found"}

              user_token -> Repo.delete(user_token)

            end

          # end "user" case

          "client" ->

            case Repo.get(App.Accounts.ClientToken, token) do

              nil -> {:error, "Not Found"}

              client_token -> Repo.delete(client_token)

            end

          # end "client" case

        end

      # end :ok case

      error -> error

    end

  end
end
