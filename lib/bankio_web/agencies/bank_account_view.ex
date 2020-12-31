defmodule AppWeb.BankAccountView do
  use AppWeb, :view
  alias AppWeb.BankAccountView

  def bank_account(bank_account) do
    %{
      id: bank_account.id,
      agency_id: bank_account.agency_id,
      code: bank_account.code,
      is_active: bank_account.is_active,
      since: bank_account.since,
      until: bank_account.until,
      inserted_at: bank_account.inserted_at,
      updated_at: bank_account.updated_at
    }
  end

  def agency(bank_account, agency) do
    case agency do
      %App.Agencies.Agency{} ->
        Map.put(bank_account, :agency, render_one(agency, AppWeb.AgencyView, "agency.json"))
        |> Map.delete(:agency_id)

      _ -> bank_account
    end
  end

  def render("index.json", %{bank_accounts: bank_accounts}) do
    render_many(bank_accounts, BankAccountView, "bank_account.json")
  end

  def render("show.json", %{bank_account: bank_account}) do
    render_one(bank_account, BankAccountView, "bank_account.json")
  end

  def render("bank_account.json", %{bank_account: bank_account}) do
    bank_account
    |> bank_account
    |> agency(bank_account.agency)
  end
end
