defmodule App.AgenciesTest do
  use App.DataCase

  alias App.Agencies

  describe "agencies" do
    alias App.Agencies.Agency

    @valid_attrs %{code: 42, is_active: true, name: "some name"}
    @update_attrs %{code: 43, is_active: false, name: "some updated name"}
    @invalid_attrs %{code: nil, is_active: nil, name: nil}

    def agency_fixture(attrs \\ %{}) do
      {:ok, agency} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Agencies.create_agency()

      agency
    end

    test "list_agencies/0 returns all agencies" do
      agency = agency_fixture()
      assert Agencies.list_agencies() == [agency]
    end

    test "get_agency!/1 returns the agency with given id" do
      agency = agency_fixture()
      assert Agencies.get_agency!(agency.id) == agency
    end

    test "create_agency/1 with valid data creates a agency" do
      assert {:ok, %Agency{} = agency} = Agencies.create_agency(@valid_attrs)
      assert agency.code == 42
      assert agency.is_active == true
      assert agency.name == "some name"
    end

    test "create_agency/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Agencies.create_agency(@invalid_attrs)
    end

    test "update_agency/2 with valid data updates the agency" do
      agency = agency_fixture()
      assert {:ok, %Agency{} = agency} = Agencies.update_agency(agency, @update_attrs)
      assert agency.code == 43
      assert agency.is_active == false
      assert agency.name == "some updated name"
    end

    test "update_agency/2 with invalid data returns error changeset" do
      agency = agency_fixture()
      assert {:error, %Ecto.Changeset{}} = Agencies.update_agency(agency, @invalid_attrs)
      assert agency == Agencies.get_agency!(agency.id)
    end

    test "delete_agency/1 deletes the agency" do
      agency = agency_fixture()
      assert {:ok, %Agency{}} = Agencies.delete_agency(agency)
      assert_raise Ecto.NoResultsError, fn -> Agencies.get_agency!(agency.id) end
    end

    test "change_agency/1 returns a agency changeset" do
      agency = agency_fixture()
      assert %Ecto.Changeset{} = Agencies.change_agency(agency)
    end
  end

  describe "agency_users" do
    alias App.Agencies.AgencyUser

    @valid_attrs %{agency_id: "some agency_id", role: "some role", since: "2010-04-17T14:00:00Z", until: "2010-04-17T14:00:00Z", user_id: "some user_id"}
    @update_attrs %{agency_id: "some updated agency_id", role: "some updated role", since: "2011-05-18T15:01:01Z", until: "2011-05-18T15:01:01Z", user_id: "some updated user_id"}
    @invalid_attrs %{agency_id: nil, role: nil, since: nil, until: nil, user_id: nil}

    def agency_user_fixture(attrs \\ %{}) do
      {:ok, agency_user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Agencies.create_agency_user()

      agency_user
    end

    test "list_agency_users/0 returns all agency_users" do
      agency_user = agency_user_fixture()
      assert Agencies.list_agency_users() == [agency_user]
    end

    test "get_agency_user!/1 returns the agency_user with given id" do
      agency_user = agency_user_fixture()
      assert Agencies.get_agency_user!(agency_user.id) == agency_user
    end

    test "create_agency_user/1 with valid data creates a agency_user" do
      assert {:ok, %AgencyUser{} = agency_user} = Agencies.create_agency_user(@valid_attrs)
      assert agency_user.agency_id == "some agency_id"
      assert agency_user.role == "some role"
      assert agency_user.since == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert agency_user.until == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert agency_user.user_id == "some user_id"
    end

    test "create_agency_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Agencies.create_agency_user(@invalid_attrs)
    end

    test "update_agency_user/2 with valid data updates the agency_user" do
      agency_user = agency_user_fixture()
      assert {:ok, %AgencyUser{} = agency_user} = Agencies.update_agency_user(agency_user, @update_attrs)
      assert agency_user.agency_id == "some updated agency_id"
      assert agency_user.role == "some updated role"
      assert agency_user.since == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert agency_user.until == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert agency_user.user_id == "some updated user_id"
    end

    test "update_agency_user/2 with invalid data returns error changeset" do
      agency_user = agency_user_fixture()
      assert {:error, %Ecto.Changeset{}} = Agencies.update_agency_user(agency_user, @invalid_attrs)
      assert agency_user == Agencies.get_agency_user!(agency_user.id)
    end

    test "delete_agency_user/1 deletes the agency_user" do
      agency_user = agency_user_fixture()
      assert {:ok, %AgencyUser{}} = Agencies.delete_agency_user(agency_user)
      assert_raise Ecto.NoResultsError, fn -> Agencies.get_agency_user!(agency_user.id) end
    end

    test "change_agency_user/1 returns a agency_user changeset" do
      agency_user = agency_user_fixture()
      assert %Ecto.Changeset{} = Agencies.change_agency_user(agency_user)
    end
  end

  describe "bank_accounts" do
    alias App.Agencies.BankAccount

    @valid_attrs %{agency_id: "some agency_id", is_active: true, since: "2010-04-17T14:00:00Z", until: "2010-04-17T14:00:00Z"}
    @update_attrs %{agency_id: "some updated agency_id", is_active: false, since: "2011-05-18T15:01:01Z", until: "2011-05-18T15:01:01Z"}
    @invalid_attrs %{agency_id: nil, is_active: nil, since: nil, until: nil}

    def bank_account_fixture(attrs \\ %{}) do
      {:ok, bank_account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Agencies.create_bank_account()

      bank_account
    end

    test "list_bank_accounts/0 returns all bank_accounts" do
      bank_account = bank_account_fixture()
      assert Agencies.list_bank_accounts() == [bank_account]
    end

    test "get_bank_account!/1 returns the bank_account with given id" do
      bank_account = bank_account_fixture()
      assert Agencies.get_bank_account!(bank_account.id) == bank_account
    end

    test "create_bank_account/1 with valid data creates a bank_account" do
      assert {:ok, %BankAccount{} = bank_account} = Agencies.create_bank_account(@valid_attrs)
      assert bank_account.agency_id == "some agency_id"
      assert bank_account.is_active == true
      assert bank_account.since == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert bank_account.until == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "create_bank_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Agencies.create_bank_account(@invalid_attrs)
    end

    test "update_bank_account/2 with valid data updates the bank_account" do
      bank_account = bank_account_fixture()
      assert {:ok, %BankAccount{} = bank_account} = Agencies.update_bank_account(bank_account, @update_attrs)
      assert bank_account.agency_id == "some updated agency_id"
      assert bank_account.is_active == false
      assert bank_account.since == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert bank_account.until == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    end

    test "update_bank_account/2 with invalid data returns error changeset" do
      bank_account = bank_account_fixture()
      assert {:error, %Ecto.Changeset{}} = Agencies.update_bank_account(bank_account, @invalid_attrs)
      assert bank_account == Agencies.get_bank_account!(bank_account.id)
    end

    test "delete_bank_account/1 deletes the bank_account" do
      bank_account = bank_account_fixture()
      assert {:ok, %BankAccount{}} = Agencies.delete_bank_account(bank_account)
      assert_raise Ecto.NoResultsError, fn -> Agencies.get_bank_account!(bank_account.id) end
    end

    test "change_bank_account/1 returns a bank_account changeset" do
      bank_account = bank_account_fixture()
      assert %Ecto.Changeset{} = Agencies.change_bank_account(bank_account)
    end
  end
end
