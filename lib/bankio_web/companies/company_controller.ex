defmodule AppWeb.CompanyController do
  use AppWeb, :controller

  alias App.Companies
  alias App.Companies.Company

  action_fallback AppWeb.FallbackController

  def index(conn, _params) do
    companies = Companies.list_companies()
    render(conn, "index.json", companies: companies)
  end

  def create(conn, params) do
    with {:ok, %Company{} = company} <- Companies.create_company(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.company_path(conn, :show, company))
      |> render("show.json", company: company)
    end
  end

  def show(conn, %{"id" => id}) do
    company = Companies.get_company!(id, :complete)
    render(conn, "show.json", company: company)
  end

  def update(conn, %{"id" => id} = params) do
    company = Companies.get_company!(id)

    with {:ok, %Company{} = company} <- Companies.update_company(company, params) do
      render(conn, "show.json", company: company)
    end
  end

  def delete(conn, %{"id" => id}) do
    company = Companies.get_company!(id)

    with {:ok, %Company{}} <- Companies.delete_company(company) do
      send_resp(conn, :no_content, "")
    end
  end
end
