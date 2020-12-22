defmodule AppWeb.CompanyClientControllerTest do
  use AppWeb.ConnCase

  alias App.Companies
  alias App.Companies.CompanyClient

  @create_attrs %{
    since: "2010-04-17T14:00:00Z",
    until: "2010-04-17T14:00:00Z"
  }
  @update_attrs %{
    since: "2011-05-18T15:01:01Z",
    until: "2011-05-18T15:01:01Z"
  }
  @invalid_attrs %{since: nil, until: nil}

  def fixture(:company_client) do
    {:ok, company_client} = Companies.create_company_client(@create_attrs)
    company_client
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all company_clients", %{conn: conn} do
      conn = get(conn, Routes.company_client_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create company_client" do
    test "renders company_client when data is valid", %{conn: conn} do
      conn = post(conn, Routes.company_client_path(conn, :create), company_client: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.company_client_path(conn, :show, id))

      assert %{
               "id" => id,
               "since" => "2010-04-17T14:00:00Z",
               "until" => "2010-04-17T14:00:00Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.company_client_path(conn, :create), company_client: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update company_client" do
    setup [:create_company_client]

    test "renders company_client when data is valid", %{conn: conn, company_client: %CompanyClient{id: id} = company_client} do
      conn = put(conn, Routes.company_client_path(conn, :update, company_client), company_client: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.company_client_path(conn, :show, id))

      assert %{
               "id" => id,
               "since" => "2011-05-18T15:01:01Z",
               "until" => "2011-05-18T15:01:01Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, company_client: company_client} do
      conn = put(conn, Routes.company_client_path(conn, :update, company_client), company_client: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete company_client" do
    setup [:create_company_client]

    test "deletes chosen company_client", %{conn: conn, company_client: company_client} do
      conn = delete(conn, Routes.company_client_path(conn, :delete, company_client))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.company_client_path(conn, :show, company_client))
      end
    end
  end

  defp create_company_client(_) do
    company_client = fixture(:company_client)
    %{company_client: company_client}
  end
end
