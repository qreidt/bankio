defmodule App.Agencies do
  @moduledoc """
  The Agencies context.
  """

  import Ecto.Query, warn: false
  alias App.Repo

  alias App.Agencies.{Agency, AgencyUser}

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
    base_query = from agency in Agency, where: agency.id == ^id

    base_query
    |> App.Agencies.preload_users
    |> Repo.one!
  end

  def preload_users(query) do
    from agency in query,
      left_join: agency_user in assoc(agency, :users),
      left_join: user in assoc(agency_user, :user),
      preload: [users: {agency_user, user: user}]
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
    Repo.get_by!(AgencyUser, user_id: user_id, agency_id: agency_id)
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
    |> AgencyUser.changeset(attrs)
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
end
