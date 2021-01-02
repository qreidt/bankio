defmodule AppWeb.BankAccountClientController do
  use AppWeb, :controller

  alias App.Agencies
  alias App.Agencies.BankAccountClient

  action_fallback AppWeb.FallbackController

  def create(conn, params) do
    with {:ok, %BankAccountClient{} = bank_account_client} <- Agencies.create_bank_account_client(params) do
      conn
      |> put_status(:created)
      |> render("show.json", bank_account_client: bank_account_client)
    end
  end

  def update(conn, %{"client_id" => client_id, "bank_account_id" => bank_account_id} = params) do
    bank_account_client = Agencies.get_bank_account_client!(client_id, bank_account_id)

    with {:ok, %BankAccountClient{} = bank_account_client} <- Agencies.update_bank_account_client(bank_account_client, params) do
      render(conn, "show.json", bank_account_client: bank_account_client)
    end
  end

  def delete(conn, %{"client_id" => client_id, "bank_account_id" => bank_account_id}) do
    bank_account_client = Agencies.get_bank_account_client!(client_id, bank_account_id)

    with {:ok, %BankAccountClient{}} <- Agencies.delete_bank_account_client(bank_account_client) do
      send_resp(conn, :no_content, "")
    end
  end
end
