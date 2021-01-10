defmodule AppWeb.CreditInvoiceController do
  use AppWeb, :controller

  alias App.Cards
  alias App.Cards.CreditInvoice

  action_fallback AppWeb.FallbackController

  def index(conn, _params) do
    credit_invoices = Cards.list_credit_invoices
    render(conn, "index.json", credit_invoices: credit_invoices)
  end

  def create(conn, params) do
    with {:ok, %CreditInvoice{} = credit_invoice} <- Cards.create_credit_invoice(params) do
      conn
      |> put_status(:created)
      |> render("show.json", credit_invoice: credit_invoice)
    end
  end

  def show(conn, %{"id" => id}) do
    credit_invoice = Cards.get_credit_invoice!(id, :complete)
    render(conn, "show.json", credit_invoice: credit_invoice)
  end

  def update(conn, %{"id" => id} = params) do
    credit_invoice = Cards.get_credit_invoice!(id)

    with {:ok, %CreditInvoice{} = credit_invoice} <- Cards.update_credit_invoice(credit_invoice, params) do
      render(conn, "show.json", credit_invoice: credit_invoice)
    end
  end

  def delete(conn, %{"id" => id}) do
    credit_invoice = Cards.get_credit_invoice!(id)

    with {:ok, %CreditInvoice{}} <- Cards.delete_credit_invoice(credit_invoice) do
      send_resp(conn, :no_content, "")
    end
  end
end
