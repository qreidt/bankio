defmodule AppWeb.CreditInvoiceView do
  use AppWeb, :view
  alias AppWeb.CreditInvoiceView

  def credit_invoice(credit_invoice) do
    %{
      id: credit_invoice.id,
      card_id: credit_invoice.card_id,
      balance: credit_invoice.balance |> Decimal.to_float,
      reference_month: credit_invoice.reference_month,
      status: credit_invoice.status,
      started: credit_invoice.started,
      ended: credit_invoice.ended,
      paid_at: credit_invoice.paid_at,
      interest: credit_invoice.interest |> Decimal.to_float
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

  def render("index.json", %{credit_invoices: credit_invoices}) do
    render_many(credit_invoices, CreditInvoiceView, "credit_invoice.json")
  end

  def render("show.json", %{credit_invoice: credit_invoice}) do
    render_one(credit_invoice, CreditInvoiceView, "credit_invoice.json")
  end

  def render("credit_invoice.json", %{credit_invoice: credit_invoice}) do
    credit_invoice
    |> credit_invoice
    |> card(credit_invoice.card)
  end
end
