defmodule App.CardsTest do
  use App.DataCase

  alias App.Cards

  describe "cards" do
    alias App.Cards.Card

    @valid_attrs %{balance: "120.5", bank_account_id: "some bank_account_id", code: 42, is_active: true, password: "some password"}
    @update_attrs %{balance: "456.7", bank_account_id: "some updated bank_account_id", code: 43, is_active: false, password: "some updated password"}
    @invalid_attrs %{balance: nil, bank_account_id: nil, code: nil, is_active: nil, password: nil}

    def card_fixture(attrs \\ %{}) do
      {:ok, card} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cards.create_card()

      card
    end

    test "list_cards/0 returns all cards" do
      card = card_fixture()
      assert Cards.list_cards() == [card]
    end

    test "get_card!/1 returns the card with given id" do
      card = card_fixture()
      assert Cards.get_card!(card.id) == card
    end

    test "create_card/1 with valid data creates a card" do
      assert {:ok, %Card{} = card} = Cards.create_card(@valid_attrs)
      assert card.balance == Decimal.new("120.5")
      assert card.bank_account_id == "some bank_account_id"
      assert card.code == 42
      assert card.is_active == true
      assert card.password == "some password"
    end

    test "create_card/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cards.create_card(@invalid_attrs)
    end

    test "update_card/2 with valid data updates the card" do
      card = card_fixture()
      assert {:ok, %Card{} = card} = Cards.update_card(card, @update_attrs)
      assert card.balance == Decimal.new("456.7")
      assert card.bank_account_id == "some updated bank_account_id"
      assert card.code == 43
      assert card.is_active == false
      assert card.password == "some updated password"
    end

    test "update_card/2 with invalid data returns error changeset" do
      card = card_fixture()
      assert {:error, %Ecto.Changeset{}} = Cards.update_card(card, @invalid_attrs)
      assert card == Cards.get_card!(card.id)
    end

    test "delete_card/1 deletes the card" do
      card = card_fixture()
      assert {:ok, %Card{}} = Cards.delete_card(card)
      assert_raise Ecto.NoResultsError, fn -> Cards.get_card!(card.id) end
    end

    test "change_card/1 returns a card changeset" do
      card = card_fixture()
      assert %Ecto.Changeset{} = Cards.change_card(card)
    end
  end
end
