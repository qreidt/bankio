defmodule AppWeb.BankAccountControllerTest do
  use AppWeb.ConnCase

  alias App.Agencies
  alias App.Agencies.BankAccount

  @create_attrs %{
    agency_id: "some agency_id",
    is_active: true,
    since: "2010-04-17T14:00:00Z",
    until: "2010-04-17T14:00:00Z"
  }
  @update_attrs %{
    agency_id: "some updated agency_id",
    is_active: false,
    since: "2011-05-18T15:01:01Z",
    until: "2011-05-18T15:01:01Z"
  }
  @invalid_attrs %{agency_id: nil, is_active: nil, since: nil, until: nil}

  def fixture(:bank_account) do
    {:ok, bank_account} = Agencies.create_bank_account(@create_attrs)
    bank_account
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all bank_accounts", %{conn: conn} do
      conn = get(conn, Routes.bank_account_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create bank_account" do
    test "renders bank_account when data is valid", %{conn: conn} do
      conn = post(conn, Routes.bank_account_path(conn, :create), bank_account: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.bank_account_path(conn, :show, id))

      assert %{
               "id" => id,
               "agency_id" => "some agency_id",
               "is_active" => true,
               "since" => "2010-04-17T14:00:00Z",
               "until" => "2010-04-17T14:00:00Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.bank_account_path(conn, :create), bank_account: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update bank_account" do
    setup [:create_bank_account]

    test "renders bank_account when data is valid", %{conn: conn, bank_account: %BankAccount{id: id} = bank_account} do
      conn = put(conn, Routes.bank_account_path(conn, :update, bank_account), bank_account: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.bank_account_path(conn, :show, id))

      assert %{
               "id" => id,
               "agency_id" => "some updated agency_id",
               "is_active" => false,
               "since" => "2011-05-18T15:01:01Z",
               "until" => "2011-05-18T15:01:01Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, bank_account: bank_account} do
      conn = put(conn, Routes.bank_account_path(conn, :update, bank_account), bank_account: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete bank_account" do
    setup [:create_bank_account]

    test "deletes chosen bank_account", %{conn: conn, bank_account: bank_account} do
      conn = delete(conn, Routes.bank_account_path(conn, :delete, bank_account))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.bank_account_path(conn, :show, bank_account))
      end
    end
  end

  defp create_bank_account(_) do
    bank_account = fixture(:bank_account)
    %{bank_account: bank_account}
  end
end
