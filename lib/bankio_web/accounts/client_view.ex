defmodule AppWeb.ClientView do
  use AppWeb, :view
  alias AppWeb.ClientView

  def companies(client, client_companies) do
    if is_list(client_companies) do
      Map.put(
        client,
        :companies,
        render_many(client_companies, AppWeb.CompanyClientView, "company_client.json")
      )

    else

      client

    end
  end

  def bank_accounts(client, bank_account_clients) do
    if is_list(bank_account_clients) do
      Map.put(
        client,
        :bank_accounts,
        render_many(bank_account_clients, AppWeb.BankAccountClientView, "bank_account-client.json")
      )

    else

      client

    end
  end

  def render("index.json", %{clients: clients}) do
    render_many(clients, ClientView, "client.json")
  end

  def render("show.json", %{client: client}) do
    render_one(client, ClientView, "client.json")
  end

  def render("client.json", %{client: client}) do
    %{
      id: client.id,
      name: client.name,
      key: client.key,
      is_active: client.is_active,
      inserted_at: client.inserted_at,
      updated_at: client.updated_at
    }
    |> companies(client.companies)
    |> bank_accounts(client.bank_accounts)
  end
end
