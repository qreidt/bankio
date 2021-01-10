defmodule AppWeb.TransactionView do
  use AppWeb, :view
  alias AppWeb.TransactionView

  def transaction(transaction) do
    %{
      id: transaction.id,
      credit_invoice_id: transaction.credit_invoice_id,
      card_id: transaction.card_id,
      value: transaction.value |> Decimal.to_float,
      executed: transaction.executed,
      execute_at: transaction.execute_at
    }
  end

  def card(credit_invoice, card) do
    case card do
      %App.Cards.Card{} ->
        Map.put(credit_invoice, :card, render_one(card, AppWeb.CardView, "card.json"))
        |> Map.delete(:card_id)

      _ -> credit_invoice
    end
  end

  def credit_invoice(transaction, credit_invoice) do
    case credit_invoice do
      %App.Cards.CreditInvoice{} ->
        Map.put(transaction, :credit_invoice, render_one(credit_invoice, AppWeb.CreditInvoiceView, "credit-invoice.json"))
        |> Map.delete(:credit_invoice_id)

      _ -> transaction
    end
  end

  def render("index.json", %{transactions: transactions}) do
    render_many(transactions, TransactionView, "transaction.json")
  end

  def render("show.json", %{transaction: transaction}) do
    render_one(transaction, TransactionView, "transaction.json")
  end

  def render("transaction.json", %{transaction: transaction}) do
    transaction
    |> transaction
    |> card(transaction.card)
    |> credit_invoice(transaction.credit_invoice)
  end
end
