defmodule App.Agencies do
  @moduledoc """
  The Agencies context.
  """

  import Ecto.Query, warn: false
  alias App.Repo

  alias App.Agencies.{Agency, AgencyUser, BankAccount, BankAccountClient}


  #############################
  #
  # Agency
  #
  #############################

  @doc """
  Returns the list of agencies.

  ## Examples

      iex> list_agencies()
      [%Agency{}, ...]

  """
  def list_agencies do
    Repo.all(Agency)
  end

  @doc """
  Gets a single agency.

  Raises `Ecto.NoResultsError` if the Agency does not exist.

  ## Examples

      iex> get_agency!(123)
      %Agency{}

      iex> get_agency!(456)
      ** (Ecto.NoResultsError)

  """
  def get_agency!(id), do: Repo.get!(Agency, id)
  def get_agency!(id, :complete) do
    Repo.get!(Agency, id)
    |> Repo.preload(:users)
    |> Repo.preload(:bank_accounts)
  end

  @doc """
  Creates a agency.

  ## Examples

      iex> create_agency(%{field: value})
      {:ok, %Agency{}}

      iex> create_agency(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_agency(attrs \\ %{}) do
    %Agency{}
    |> Agency.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a agency.

  ## Examples

      iex> update_agency(agency, %{field: new_value})
      {:ok, %Agency{}}

      iex> update_agency(agency, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_agency(%Agency{} = agency, attrs) do
    agency
    |> Agency.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a agency.

  ## Examples

      iex> delete_agency(agency)
      {:ok, %Agency{}}

      iex> delete_agency(agency)
      {:error, %Ecto.Changeset{}}

  """
  def delete_agency(%Agency{} = agency) do
    Repo.delete(agency)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking agency changes.

  ## Examples

      iex> change_agency(agency)
      %Ecto.Changeset{data: %Agency{}}

  """
  def change_agency(%Agency{} = agency, attrs \\ %{}) do
    Agency.changeset(agency, attrs)
  end


  #############################
  #
  # User Agency
  #
  #############################

  @doc """
  Gets a single agency_user.

  Raises `Ecto.NoResultsError` if the Agency user does not exist.

  ## Examples

      iex> get_agency_user!(123)
      %AgencyUser{}

      iex> get_agency_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_agency_user!(user_id, agency_id) do
    Repo.get_by!(
      AgencyUser,
      user_id: user_id,
      agency_id: agency_id
    )
  end

  @doc """
  Creates a agency_user.

  ## Examples

      iex> create_agency_user(%{field: value})
      {:ok, %AgencyUser{}}

      iex> create_agency_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_agency_user(attrs \\ %{}) do
    %AgencyUser{}
    |> AgencyUser.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a agency_user.

  ## Examples

      iex> update_agency_user(agency_user, %{field: new_value})
      {:ok, %AgencyUser{}}

      iex> update_agency_user(agency_user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_agency_user(%AgencyUser{} = agency_user, attrs) do
    agency_user
    |> AgencyUser.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a agency_user.

  ## Examples

      iex> delete_agency_user(agency_user)
      {:ok, %AgencyUser{}}

      iex> delete_agency_user(agency_user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_agency_user(%AgencyUser{} = agency_user) do
    Repo.delete(agency_user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking agency_user changes.

  ## Examples

      iex> change_agency_user(agency_user)
      %Ecto.Changeset{data: %AgencyUser{}}

  """
  def change_agency_user(%AgencyUser{} = agency_user, attrs \\ %{}) do
    AgencyUser.changeset(agency_user, attrs)
  end


  #############################
  #
  # Bank Account
  #
  #############################

  @doc """
  Returns the list of bank_accounts.

  ## Examples

      iex> list_bank_accounts()
      [%BankAccount{}, ...]

  """
  def list_bank_accounts do
    Repo.all(BankAccount)
  end

  @doc """
  Gets a single bank_account.

  Raises `Ecto.NoResultsError` if the Bank account does not exist.

  ## Examples

      iex> get_bank_account!(123)
      %BankAccount{}

      iex> get_bank_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bank_account!(id), do: Repo.get!(BankAccount, id)

  def get_bank_account!(id, :complete) do
    Repo.get!(BankAccount, id)
    |> Repo.preload(:agency)
    |> Repo.preload(clients: :client)
    |> Repo.preload(:cards)
  end

  @doc """
  Creates a bank_account.

  ## Examples

      iex> create_bank_account(%{field: value})
      {:ok, %BankAccount{}}

      iex> create_bank_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bank_account(attrs \\ %{}) do
    %BankAccount{}
    |> BankAccount.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bank_account.

  ## Examples

      iex> update_bank_account(bank_account, %{field: new_value})
      {:ok, %BankAccount{}}

      iex> update_bank_account(bank_account, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bank_account(%BankAccount{} = bank_account, attrs) do
    bank_account
    |> BankAccount.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bank_account.

  ## Examples

      iex> delete_bank_account(bank_account)
      {:ok, %BankAccount{}}

      iex> delete_bank_account(bank_account)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bank_account(%BankAccount{} = bank_account) do
    Repo.delete(bank_account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bank_account changes.

  ## Examples

      iex> change_bank_account(bank_account)
      %Ecto.Changeset{data: %BankAccount{}}

  """
  def change_bank_account(%BankAccount{} = bank_account, attrs \\ %{}) do
    BankAccount.changeset(bank_account, attrs)
  end


  #############################
  #
  # Bank Account Client
  #
  #############################


  @doc """
  Gets a single bank_account_client.

  Raises `Ecto.NoResultsError` if the Bank account client does not exist.

  ## Examples

      iex> get_bank_account_client!(123)
      %BankAccountClient{}

      iex> get_bank_account_client!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bank_account_client!(client_id, bank_account_id) do
    Repo.get_by!(
      BankAccountClient,
      client_id: client_id,
      bank_account_id: bank_account_id
    )
  end

  @doc """
  Creates a bank_account_client.

  ## Examples

      iex> create_bank_account_client(%{field: value})
      {:ok, %BankAccountClient{}}

      iex> create_bank_account_client(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bank_account_client(attrs \\ %{}) do
    %BankAccountClient{}
    |> BankAccountClient.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bank_account_client.

  ## Examples

      iex> update_bank_account_client(bank_account_client, %{field: new_value})
      {:ok, %BankAccountClient{}}

      iex> update_bank_account_client(bank_account_client, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bank_account_client(%BankAccountClient{} = bank_account_client, attrs) do
    bank_account_client
    |> BankAccountClient.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bank_account_client.

  ## Examples

      iex> delete_bank_account_client(bank_account_client)
      {:ok, %BankAccountClient{}}

      iex> delete_bank_account_client(bank_account_client)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bank_account_client(%BankAccountClient{} = bank_account_client) do
    Repo.delete(bank_account_client)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bank_account_client changes.

  ## Examples

      iex> change_bank_account_client(bank_account_client)
      %Ecto.Changeset{data: %BankAccountClient{}}

  """
  def change_bank_account_client(%BankAccountClient{} = bank_account_client, attrs \\ %{}) do
    BankAccountClient.changeset(bank_account_client, attrs)
  end
end
