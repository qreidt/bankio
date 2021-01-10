defmodule AppWeb.CardController do
  use AppWeb, :controller

  alias App.Cards
  alias App.Cards.Card

  action_fallback AppWeb.FallbackController

  def index(conn, _params) do
    cards = Cards.list_cards()
    render(conn, "index.json", cards: cards)
  end

  def create(conn, params) do
    with {:ok, %Card{} = card} <- Cards.create_card(params) do
      conn
      |> put_status(:created)
      |> render("show.json", card: card)
    end
  end

  def show(conn, %{"id" => id}) do
    card = Cards.get_card!(id, :complete)
    render(conn, "show.json", card: card)
  end

  def update(conn, %{"id" => id} = params) do
    card = Cards.get_card!(id)

    with {:ok, %Card{} = card} <- Cards.update_card(card, params) do
      render(conn, "show.json", card: card)
    end
  end

  def delete(conn, %{"id" => id}) do
    card = Cards.get_card!(id)

    with {:ok, %Card{}} <- Cards.delete_card(card) do
      send_resp(conn, :no_content, "")
    end
  end
end
