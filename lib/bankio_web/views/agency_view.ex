defmodule AppWeb.AgencyView do
  use AppWeb, :view
  alias AppWeb.AgencyView

  def render("index.json", %{agencies: agencies}) do
    render_many(agencies, AgencyView, "agency.json")
  end

  def render("show.json", %{agency: agency}) do
    render_one(agency, AgencyView, "agency.json")
  end

  def render("agency.json", %{agency: agency}) do
    %{
      id: agency.id,
      code: agency.code,
      name: agency.name,
      is_active: agency.is_active
    }
  end
end
