defmodule AppWeb.CompanyClientController do
  use AppWeb, :controller

  alias App.Companies
  alias App.Companies.CompanyClient

  action_fallback AppWeb.FallbackController

  def create(conn, params) do
    with {:ok, %CompanyClient{} = company_client} <- Companies.create_company_client(params) do
      conn
      |> put_status(:created)
      |> render("show.json", company_client: company_client)
    end
  end

  def update(conn, %{"company_id" => company_id, "client_id" => client_id} = params) do
    company_client = Companies.get_company_client!(company_id, client_id)

    with {:ok, %CompanyClient{} = company_client} <- Companies.update_company_client(company_client, params) do
      render(conn, "show.json", company_client: company_client)
    end
  end

  def delete(conn, %{"company_id" => company_id, "client_id" => client_id}) do
    company_client = Companies.get_company_client!(company_id, client_id)

    with {:ok, %CompanyClient{}} <- Companies.delete_company_client(company_client) do
      send_resp(conn, :no_content, "")
    end
  end
end
