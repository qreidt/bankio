defmodule AppWeb.CompanyView do
  use AppWeb, :view
  alias AppWeb.CompanyView

  def company(company) do
    %{
      id: company.id,
      name: company.name,
      document: company.document,
      is_active: company.is_active,
      inserted_at: company.inserted_at,
      updated_at: company.updated_at
    }
  end

  def members(company, company_members) do
    if is_list(company_members) do
      Map.put(
        company,
        :members,
        render_many(company_members, AppWeb.CompanyClientView, "company_client.json")
      )

    else

      company

    end
  end

  def render("index.json", %{companies: companies}) do
    render_many(companies, CompanyView, "company.json")
  end

  def render("show.json", %{company: company}) do
    render_one(company, CompanyView, "company.json")
  end

  def render("company.json", %{company: company}) do
    company(company)
    |> members(company.members)
  end
end
