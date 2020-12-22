defmodule AppWeb.AgencyControllerTest do
  use AppWeb.ConnCase

  alias App.Agencies
  alias App.Agencies.Agency

  @create_attrs %{
    code: 42,
    is_active: true,
    name: "some name"
  }
  @update_attrs %{
    code: 43,
    is_active: false,
    name: "some updated name"
  }
  @invalid_attrs %{code: nil, is_active: nil, name: nil}

  def fixture(:agency) do
    {:ok, agency} = Agencies.create_agency(@create_attrs)
    agency
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all agencies", %{conn: conn} do
      conn = get(conn, Routes.agency_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create agency" do
    test "renders agency when data is valid", %{conn: conn} do
      conn = post(conn, Routes.agency_path(conn, :create), agency: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.agency_path(conn, :show, id))

      assert %{
               "id" => id,
               "code" => 42,
               "is_active" => true,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.agency_path(conn, :create), agency: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update agency" do
    setup [:create_agency]

    test "renders agency when data is valid", %{conn: conn, agency: %Agency{id: id} = agency} do
      conn = put(conn, Routes.agency_path(conn, :update, agency), agency: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.agency_path(conn, :show, id))

      assert %{
               "id" => id,
               "code" => 43,
               "is_active" => false,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, agency: agency} do
      conn = put(conn, Routes.agency_path(conn, :update, agency), agency: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete agency" do
    setup [:create_agency]

    test "deletes chosen agency", %{conn: conn, agency: agency} do
      conn = delete(conn, Routes.agency_path(conn, :delete, agency))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.agency_path(conn, :show, agency))
      end
    end
  end

  defp create_agency(_) do
    agency = fixture(:agency)
    %{agency: agency}
  end
end
