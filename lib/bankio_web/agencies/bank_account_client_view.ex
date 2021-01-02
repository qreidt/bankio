defmodule AppWeb.BankAccountClientView do
  use AppWeb, :view
  alias AppWeb.BankAccountClientView

  def bank_account_client(bank_account_client) do
    %{
      client_id: bank_account_client.client_id,
      bank_account_id: bank_account_client.bank_account_id,
      since: bank_account_client.since,
      until: bank_account_client.until
    }
  end

  def client(bank_account_client, client) do
    case client do
      %App.Accounts.Client{} ->
        Map.put(bank_account_client, :client, render_one(client, AppWeb.ClientView, "client.json"))
        |> Map.delete(:client_id)

      _ -> bank_account_client
    end
  end

  def bank_account(bank_account_client, bank_account) do
    case bank_account do
      %App.Agencies.BankAccount{} ->
        Map.put(bank_account_client, :bank_account, render_one(bank_account, AppWeb.BankAccountView, "bank_account.json"))
        |> Map.delete(:bank_account_id)

      _ -> bank_account_client
    end
  end

  def render("index.json", %{bank_account_client: bank_account_client}) do
    render_many(bank_account_client, BankAccountClientView, "bank_account-client.json")
  end

  def render("show.json", %{bank_account_client: bank_account_client}) do
    render_one(bank_account_client, BankAccountClientView, "bank_account-client.json")
  end

  def render("bank_account-client.json", %{bank_account_client: bank_account_client}) do

    bank_account_client
    |> BankAccountClientView.bank_account_client
    |> BankAccountClientView.client(bank_account_client.client)
    |> BankAccountClientView.bank_account(bank_account_client.bank_account)

  end
end
