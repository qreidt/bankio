defmodule AppWeb.BankAccountClientControllerTest do
  use AppWeb.ConnCase

  alias App.Agencies
  alias App.Agencies.BankAccountClient

  @create_attrs %{
    bank_account_id: "some bank_account_id",
    client_id: "some client_id",
    since: "2010-04-17T14:00:00Z",
    until: "2010-04-17T14:00:00Z"
  }
  @update_attrs %{
    bank_account_id: "some updated bank_account_id",
    client_id: "some updated client_id",
    since: "2011-05-18T15:01:01Z",
    until: "2011-05-18T15:01:01Z"
  }
  @invalid_attrs %{bank_account_id: nil, client_id: nil, since: nil, until: nil}

  def fixture(:bank_account_client) do
    {:ok, bank_account_client} = Agencies.create_bank_account_client(@create_attrs)
    bank_account_client
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all bank_account_client", %{conn: conn} do
      conn = get(conn, Routes.bank_account_client_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create bank_account_client" do
    test "renders bank_account_client when data is valid", %{conn: conn} do
      conn = post(conn, Routes.bank_account_client_path(conn, :create), bank_account_client: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.bank_account_client_path(conn, :show, id))

      assert %{
               "id" => id,
               "bank_account_id" => "some bank_account_id",
               "client_id" => "some client_id",
               "since" => "2010-04-17T14:00:00Z",
               "until" => "2010-04-17T14:00:00Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.bank_account_client_path(conn, :create), bank_account_client: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update bank_account_client" do
    setup [:create_bank_account_client]

    test "renders bank_account_client when data is valid", %{conn: conn, bank_account_client: %BankAccountClient{id: id} = bank_account_client} do
      conn = put(conn, Routes.bank_account_client_path(conn, :update, bank_account_client), bank_account_client: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.bank_account_client_path(conn, :show, id))

      assert %{
               "id" => id,
               "bank_account_id" => "some updated bank_account_id",
               "client_id" => "some updated client_id",
               "since" => "2011-05-18T15:01:01Z",
               "until" => "2011-05-18T15:01:01Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, bank_account_client: bank_account_client} do
      conn = put(conn, Routes.bank_account_client_path(conn, :update, bank_account_client), bank_account_client: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete bank_account_client" do
    setup [:create_bank_account_client]

    test "deletes chosen bank_account_client", %{conn: conn, bank_account_client: bank_account_client} do
      conn = delete(conn, Routes.bank_account_client_path(conn, :delete, bank_account_client))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.bank_account_client_path(conn, :show, bank_account_client))
      end
    end
  end

  defp create_bank_account_client(_) do
    bank_account_client = fixture(:bank_account_client)
    %{bank_account_client: bank_account_client}
  end
end
