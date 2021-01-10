defmodule AppWeb.TransactionController do
  use AppWeb, :controller

  alias App.Cards
  alias App.Cards.Transaction

  action_fallback AppWeb.FallbackController

  def index(conn, _params) do
    transactions = Cards.list_transactions()
    render(conn, "index.json", transactions: transactions)
  end

  def create(conn, params) do
    with {:ok, %Transaction{} = transaction} <- Cards.create_transaction(params) do
      conn
      |> put_status(:created)
      |> render("show.json", transaction: transaction)
    end
  end

  def show(conn, %{"id" => id}) do
    transaction = Cards.get_transaction!(id, :complete)
    render(conn, "show.json", transaction: transaction)
  end

  def update(conn, %{"id" => id} = params) do
    transaction = Cards.get_transaction!(id)

    with {:ok, %Transaction{} = transaction} <- Cards.update_transaction(transaction, params) do
      render(conn, "show.json", transaction: transaction)
    end
  end

  def delete(conn, %{"id" => id}) do
    transaction = Cards.get_transaction!(id)

    with {:ok, %Transaction{}} <- Cards.delete_transaction(transaction) do
      send_resp(conn, :no_content, "")
    end
  end
end
