defmodule App.CompaniesTest do
  use App.DataCase

  alias App.Companies

  describe "companies" do
    alias App.Companies.Company

    @valid_attrs %{document: "some document", is_active: true, name: "some name"}
    @update_attrs %{document: "some updated document", is_active: false, name: "some updated name"}
    @invalid_attrs %{document: nil, is_active: nil, name: nil}

    def company_fixture(attrs \\ %{}) do
      {:ok, company} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Companies.create_company()

      company
    end

    test "list_companies/0 returns all companies" do
      company = company_fixture()
      assert Companies.list_companies() == [company]
    end

    test "get_company!/1 returns the company with given id" do
      company = company_fixture()
      assert Companies.get_company!(company.id) == company
    end

    test "create_company/1 with valid data creates a company" do
      assert {:ok, %Company{} = company} = Companies.create_company(@valid_attrs)
      assert company.document == "some document"
      assert company.is_active == true
      assert company.name == "some name"
    end

    test "create_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Companies.create_company(@invalid_attrs)
    end

    test "update_company/2 with valid data updates the company" do
      company = company_fixture()
      assert {:ok, %Company{} = company} = Companies.update_company(company, @update_attrs)
      assert company.document == "some updated document"
      assert company.is_active == false
      assert company.name == "some updated name"
    end

    test "update_company/2 with invalid data returns error changeset" do
      company = company_fixture()
      assert {:error, %Ecto.Changeset{}} = Companies.update_company(company, @invalid_attrs)
      assert company == Companies.get_company!(company.id)
    end

    test "delete_company/1 deletes the company" do
      company = company_fixture()
      assert {:ok, %Company{}} = Companies.delete_company(company)
      assert_raise Ecto.NoResultsError, fn -> Companies.get_company!(company.id) end
    end

    test "change_company/1 returns a company changeset" do
      company = company_fixture()
      assert %Ecto.Changeset{} = Companies.change_company(company)
    end
  end

  describe "company_clients" do
    alias App.Companies.CompanyClient

    @valid_attrs %{since: "2010-04-17T14:00:00Z", until: "2010-04-17T14:00:00Z"}
    @update_attrs %{since: "2011-05-18T15:01:01Z", until: "2011-05-18T15:01:01Z"}
    @invalid_attrs %{since: nil, until: nil}

    def company_client_fixture(attrs \\ %{}) do
      {:ok, company_client} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Companies.create_company_client()

      company_client
    end

    test "list_company_clients/0 returns all company_clients" do
      company_client = company_client_fixture()
      assert Companies.list_company_clients() == [company_client]
    end

    test "get_company_client!/1 returns the company_client with given id" do
      company_client = company_client_fixture()
      assert Companies.get_company_client!(company_client.id) == company_client
    end

    test "create_company_client/1 with valid data creates a company_client" do
      assert {:ok, %CompanyClient{} = company_client} = Companies.create_company_client(@valid_attrs)
      assert company_client.since == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert company_client.until == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "create_company_client/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Companies.create_company_client(@invalid_attrs)
    end

    test "update_company_client/2 with valid data updates the company_client" do
      company_client = company_client_fixture()
      assert {:ok, %CompanyClient{} = company_client} = Companies.update_company_client(company_client, @update_attrs)
      assert company_client.since == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert company_client.until == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    end

    test "update_company_client/2 with invalid data returns error changeset" do
      company_client = company_client_fixture()
      assert {:error, %Ecto.Changeset{}} = Companies.update_company_client(company_client, @invalid_attrs)
      assert company_client == Companies.get_company_client!(company_client.id)
    end

    test "delete_company_client/1 deletes the company_client" do
      company_client = company_client_fixture()
      assert {:ok, %CompanyClient{}} = Companies.delete_company_client(company_client)
      assert_raise Ecto.NoResultsError, fn -> Companies.get_company_client!(company_client.id) end
    end

    test "change_company_client/1 returns a company_client changeset" do
      company_client = company_client_fixture()
      assert %Ecto.Changeset{} = Companies.change_company_client(company_client)
    end
  end
end
