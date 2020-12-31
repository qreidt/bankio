defmodule AppWeb.AgencyUserController do
  use AppWeb, :controller

  alias App.Agencies
  alias App.Agencies.AgencyUser

  action_fallback AppWeb.FallbackController

  def create(conn, params) do
    with {:ok, %AgencyUser{} = agency_user} <- Agencies.create_agency_user(params) do
      conn
      |> put_status(:created)
      |> render("show.json", agency_user: agency_user)
    end
  end

  def update(conn, %{"agency_id" => agency_id, "user_id" => user_id} = params) do
    agency_user = Agencies.get_agency_user!(user_id, agency_id)

    with {:ok, %AgencyUser{} = agency_user} <- Agencies.update_agency_user(agency_user, params) do
      render(conn, "show.json", agency_user: agency_user)
    end
  end

  def delete(conn, %{"agency_id" => agency_id, "user_id" => user_id}) do
    agency_user = Agencies.get_agency_user!(user_id, agency_id)

    with {:ok, %AgencyUser{}} <- Agencies.delete_agency_user(agency_user) do
      send_resp(conn, :no_content, "")
    end
  end
end
