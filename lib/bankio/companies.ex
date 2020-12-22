defmodule App.Companies do
  @moduledoc """
  The Companies context.
  """

  import Ecto.Query, warn: false
  alias App.Repo

  alias App.Companies.{Company, CompanyClient}

  @doc """
  Returns the list of companies.

  ## Examples

      iex> list_companies()
      [%Company{}, ...]

  """
  def list_companies do
    Repo.all(Company)
  end

  @doc """
  Gets a single company.

  Raises `Ecto.NoResultsError` if the Company does not exist.

  ## Examples

      iex> get_company!(123)
      %Company{}

      iex> get_company!(456)
      ** (Ecto.NoResultsError)

  """
  def get_company!(id), do: Repo.get!(Company, id)
  def get_company!(id, relations) do
    Repo.get!(Company, id)
    |> Repo.preload(relations)
  end

  def get_company_with_members!(id) do
    Repo.one!(
      from company in Company,
      where: company.id == ^id,
      join: member in assoc(company, :members),
      join: client in assoc(member, :client),
      preload: [members: {member, client: client}]
    )
  end

  @doc """
  Creates a company.

  ## Examples

      iex> create_company(%{field: value})
      {:ok, %Company{}}

      iex> create_company(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_company(attrs \\ %{}) do
    %Company{}
    |> Company.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a company.

  ## Examples

      iex> update_company(company, %{field: new_value})
      {:ok, %Company{}}

      iex> update_company(company, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_company(%Company{} = company, attrs) do
    company
    |> Company.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a company.

  ## Examples

      iex> delete_company(company)
      {:ok, %Company{}}

      iex> delete_company(company)
      {:error, %Ecto.Changeset{}}

  """
  def delete_company(%Company{} = company) do
    Repo.delete(company)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking company changes.

  ## Examples

      iex> change_company(company)
      %Ecto.Changeset{data: %Company{}}

  """
  def change_company(%Company{} = company, attrs \\ %{}) do
    Company.changeset(company, attrs)
  end



  @doc """
  Gets a single company_client.

  Raises `Ecto.NoResultsError` if the CompanyClient does not exist.

  ## Examples

      iex> get_company_client!(123)
      %Company{}

      iex> get_company_client!(456)
      ** (Ecto.NoResultsError)

  """
  def get_company_client!(company_id, client_id) do
    Repo.get_by!(CompanyClient, company_id: company_id, client_id: client_id)
  end

  @doc """
  Creates a company_client.

  ## Examples

      iex> create_company_client(%{field: value})
      {:ok, %CompanyClient{}}

      iex> create_company_client(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_company_client(attrs \\ %{}) do
    %CompanyClient{}
    |> CompanyClient.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a company_client.

  ## Examples

      iex> update_company_client(new_value)
      {:ok, %CompanyClient{}}

      iex> update_company_client(bad_value)
      {:error, %Ecto.Changeset{}}

  """
  def update_company_client(%CompanyClient{} = company_client, attrs \\ %{}) do
    company_client
    |> CompanyClient.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a company_client.

  ## Examples

      iex> delete_company_client(company_client)
      {:ok, %CompanyClient{}}

      iex> delete_company_client(company_client)
      {:error, %Ecto.Changeset{}}

  """
  def delete_company_client(%CompanyClient{} = company_client) do
    company_client
    |> CompanyClient.changeset(%{until: Time.utc_now})
    |> Repo.update()
  end
end
