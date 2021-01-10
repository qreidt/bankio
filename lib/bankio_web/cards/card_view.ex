defmodule AppWeb.CardView do
  use AppWeb, :view
  alias AppWeb.CardView

  def card(card) do
    %{
      id: card.id,
      bank_account_id: card.bank_account_id,
      code: card.code,
      is_active: card.is_active,
      inserted_at: card.inserted_at,
      updated_at: card.updated_at
    }
  end

  def bank_account(card, bank_account) do
    case bank_account do
      %App.Agencies.BankAccount{} ->
        Map.put(card, :bank_account, render_one(bank_account, AppWeb.BankAccountView, "bank_account.json"))
        |> Map.delete(:bank_account_id)

      _ -> card
    end
  end

  def render("index.json", %{cards: cards}) do
    render_many(cards, CardView, "card.json")
  end

  def render("show.json", %{card: card}) do
    render_one(card, CardView, "card.json")
  end

  def render("card.json", %{card: card}) do
    card
    |> card
    |> bank_account(card.bank_account)
  end
end
