defmodule AppWeb.CompanyClientView do
  use AppWeb, :view
  alias AppWeb.CompanyClientView

  def company_client(company_client) do
    %{
      company_id: company_client.company_id,
      client_id: company_client.client_id,
      since: company_client.since,
      until: company_client.until,
      inserted_at: company_client.inserted_at,
      updated_at: company_client.updated_at
    }
  end

  def client(company_client, client) do
    case client do
      %App.Accounts.Client{} ->
        Map.put(company_client, :client, render_one(client, AppWeb.ClientView, "client.json"))
        |> Map.delete(:client_id)

      _ -> company_client
    end
  end

  def company(company_client, company) do
    case company do
      %App.Companies.Company{} ->
        Map.put(company_client, :company, render_one(company, AppWeb.CompanyView, "company.json"))
        |> Map.delete(:company_id)

      _ -> company_client
    end
  end

  def render("index.json", %{company_clients: company_clients}) do
    render_many(company_clients, CompanyClientView, "company_client.json")
  end

  def render("show.json", %{company_client: company_client}) do
    render_one(company_client, CompanyClientView, "company_client.json")
  end

  def render("company_client.json", %{company_client: company_client}) do
    company_client
    |> company_client
    |> client(company_client.client)
    |> company(company_client.company)
  end
end
