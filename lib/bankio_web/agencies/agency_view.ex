defmodule AppWeb.AgencyView do
  use AppWeb, :view
  alias AppWeb.AgencyView

  def agency(agency) do
    %{
      id: agency.id,
      code: agency.code,
      name: agency.name,
      is_active: agency.is_active,
      inserted_at: agency.inserted_at,
      updated_at: agency.updated_at
    }
  end

  def users(agency, agency_users) do
    if is_list(agency_users) do
      Map.put(
        agency,
        :users,
        render_many(agency_users, AppWeb.AgencyUserView, "agency-user.json")
      )

    else

      agency

    end
  end

  def bank_accounts(agency, bank_accounts) do
    if is_list(bank_accounts) do
      Map.put(
        agency,
        :bank_accounts,
        render_many(bank_accounts, AppWeb.BankAccountView, "bank_account.json")
      )

    else

      agency

    end
  end

  def render("index.json", %{agencies: agencies}) do
    render_many(agencies, AgencyView, "agency.json")
  end

  def render("show.json", %{agency: agency}) do
    render_one(agency, AgencyView, "agency.json")
  end

  def render("agency.json", %{agency: agency}) do
    agency
    |> AgencyView.agency
    |> AgencyView.users(agency.users)
    |> AgencyView.bank_accounts(agency.bank_accounts)
  end
end
