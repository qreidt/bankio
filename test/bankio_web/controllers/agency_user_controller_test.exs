defmodule AppWeb.AgencyUserControllerTest do
  use AppWeb.ConnCase

  alias App.Agencies
  alias App.Agencies.AgencyUser

  @create_attrs %{
    agency_id: "some agency_id",
    role: "some role",
    since: "2010-04-17T14:00:00Z",
    until: "2010-04-17T14:00:00Z",
    user_id: "some user_id"
  }
  @update_attrs %{
    agency_id: "some updated agency_id",
    role: "some updated role",
    since: "2011-05-18T15:01:01Z",
    until: "2011-05-18T15:01:01Z",
    user_id: "some updated user_id"
  }
  @invalid_attrs %{agency_id: nil, role: nil, since: nil, until: nil, user_id: nil}

  def fixture(:agency_user) do
    {:ok, agency_user} = Agencies.create_agency_user(@create_attrs)
    agency_user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all agency_users", %{conn: conn} do
      conn = get(conn, Routes.agency_user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create agency_user" do
    test "renders agency_user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.agency_user_path(conn, :create), agency_user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.agency_user_path(conn, :show, id))

      assert %{
               "id" => id,
               "agency_id" => "some agency_id",
               "role" => "some role",
               "since" => "2010-04-17T14:00:00Z",
               "until" => "2010-04-17T14:00:00Z",
               "user_id" => "some user_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.agency_user_path(conn, :create), agency_user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update agency_user" do
    setup [:create_agency_user]

    test "renders agency_user when data is valid", %{conn: conn, agency_user: %AgencyUser{id: id} = agency_user} do
      conn = put(conn, Routes.agency_user_path(conn, :update, agency_user), agency_user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.agency_user_path(conn, :show, id))

      assert %{
               "id" => id,
               "agency_id" => "some updated agency_id",
               "role" => "some updated role",
               "since" => "2011-05-18T15:01:01Z",
               "until" => "2011-05-18T15:01:01Z",
               "user_id" => "some updated user_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, agency_user: agency_user} do
      conn = put(conn, Routes.agency_user_path(conn, :update, agency_user), agency_user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete agency_user" do
    setup [:create_agency_user]

    test "deletes chosen agency_user", %{conn: conn, agency_user: agency_user} do
      conn = delete(conn, Routes.agency_user_path(conn, :delete, agency_user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.agency_user_path(conn, :show, agency_user))
      end
    end
  end

  defp create_agency_user(_) do
    agency_user = fixture(:agency_user)
    %{agency_user: agency_user}
  end
end
