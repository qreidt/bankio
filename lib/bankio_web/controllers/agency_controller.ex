defmodule AppWeb.AgencyController do
  use AppWeb, :controller

  alias App.Agencies
  alias App.Agencies.Agency

  action_fallback AppWeb.FallbackController

  def index(conn, _params) do
    agencies = Agencies.list_agencies()
    render(conn, "index.json", agencies: agencies)
  end

  def create(conn, params) do
    with {:ok, %Agency{} = agency} <- Agencies.create_agency(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.agency_path(conn, :show, agency))
      |> render("show.json", agency: agency)
    end
  end

  def show(conn, %{"id" => id}) do
    agency = Agencies.get_agency!(id)
    render(conn, "show.json", agency: agency)
  end

  def update(conn, %{"id" => id} = params) do
    agency = Agencies.get_agency!(id)

    with {:ok, %Agency{} = agency} <- Agencies.update_agency(agency, params) do
      render(conn, "show.json", agency: agency)
    end
  end

  def delete(conn, %{"id" => id}) do
    agency = Agencies.get_agency!(id)

    with {:ok, %Agency{}} <- Agencies.delete_agency(agency) do
      send_resp(conn, :no_content, "")
    end
  end
end
