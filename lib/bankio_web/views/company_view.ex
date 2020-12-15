defmodule AppWeb.CompanyView do
  use AppWeb, :view
  alias AppWeb.CompanyView

  def render("index.json", %{companies: companies}) do
    render_many(companies, CompanyView, "company.json")
  end

  def render("show.json", %{company: company}) do
    render_one(company, CompanyView, "company.json")
  end

  def render("company.json", %{company: company}) do
    %{
      id: company.id,
      name: company.name,
      document: company.document,
      is_active: company.is_active
    }
  end
end
