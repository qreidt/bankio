defmodule AppWeb.BankAccountController do
  use AppWeb, :controller

  alias App.Agencies
  alias App.Agencies.BankAccount

  action_fallback AppWeb.FallbackController

  def index(conn, _params) do
    bank_accounts = Agencies.list_bank_accounts()
    render(conn, "index.json", bank_accounts: bank_accounts)
  end

  def create(conn, params) do
    with {:ok, %BankAccount{} = bank_account} <- Agencies.create_bank_account(params) do
      conn
      |> put_status(:created)
      |> render("show.json", bank_account: bank_account)
    end
  end

  def show(conn, %{"id" => id}) do
    bank_account = Agencies.get_bank_account!(id, :complete)
    render(conn, "show.json", bank_account: bank_account)
  end

  def update(conn, %{"id" => id} = params) do
    bank_account = Agencies.get_bank_account!(id)

    with {:ok, %BankAccount{} = bank_account} <- Agencies.update_bank_account(bank_account, params) do
      render(conn, "show.json", bank_account: bank_account)
    end
  end

  def delete(conn, %{"id" => id}) do
    bank_account = Agencies.get_bank_account!(id)

    with {:ok, %BankAccount{}} <- Agencies.delete_bank_account(bank_account) do
      send_resp(conn, :no_content, "")
    end
  end
end
