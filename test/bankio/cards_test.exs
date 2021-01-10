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

  describe "credit_invoices" do
    alias App.Cards.CreditInvoice

    @valid_attrs %{balance: "120.5", card_id: "some card_id", ended: "2010-04-17T14:00:00Z", interest: "120.5", paid_at: "2010-04-17T14:00:00Z", reference_month: ~D[2010-04-17], started: "2010-04-17T14:00:00Z", status: 42}
    @update_attrs %{balance: "456.7", card_id: "some updated card_id", ended: "2011-05-18T15:01:01Z", interest: "456.7", paid_at: "2011-05-18T15:01:01Z", reference_month: ~D[2011-05-18], started: "2011-05-18T15:01:01Z", status: 43}
    @invalid_attrs %{balance: nil, card_id: nil, ended: nil, interest: nil, paid_at: nil, reference_month: nil, started: nil, status: nil}

    def credit_invoice_fixture(attrs \\ %{}) do
      {:ok, credit_invoice} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cards.create_credit_invoice()

      credit_invoice
    end

    test "list_credit_invoices/0 returns all credit_invoices" do
      credit_invoice = credit_invoice_fixture()
      assert Cards.list_credit_invoices() == [credit_invoice]
    end

    test "get_credit_invoice!/1 returns the credit_invoice with given id" do
      credit_invoice = credit_invoice_fixture()
      assert Cards.get_credit_invoice!(credit_invoice.id) == credit_invoice
    end

    test "create_credit_invoice/1 with valid data creates a credit_invoice" do
      assert {:ok, %CreditInvoice{} = credit_invoice} = Cards.create_credit_invoice(@valid_attrs)
      assert credit_invoice.balance == Decimal.new("120.5")
      assert credit_invoice.card_id == "some card_id"
      assert credit_invoice.ended == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert credit_invoice.interest == Decimal.new("120.5")
      assert credit_invoice.paid_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert credit_invoice.reference_month == ~D[2010-04-17]
      assert credit_invoice.started == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert credit_invoice.status == 42
    end

    test "create_credit_invoice/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cards.create_credit_invoice(@invalid_attrs)
    end

    test "update_credit_invoice/2 with valid data updates the credit_invoice" do
      credit_invoice = credit_invoice_fixture()
      assert {:ok, %CreditInvoice{} = credit_invoice} = Cards.update_credit_invoice(credit_invoice, @update_attrs)
      assert credit_invoice.balance == Decimal.new("456.7")
      assert credit_invoice.card_id == "some updated card_id"
      assert credit_invoice.ended == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert credit_invoice.interest == Decimal.new("456.7")
      assert credit_invoice.paid_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert credit_invoice.reference_month == ~D[2011-05-18]
      assert credit_invoice.started == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert credit_invoice.status == 43
    end

    test "update_credit_invoice/2 with invalid data returns error changeset" do
      credit_invoice = credit_invoice_fixture()
      assert {:error, %Ecto.Changeset{}} = Cards.update_credit_invoice(credit_invoice, @invalid_attrs)
      assert credit_invoice == Cards.get_credit_invoice!(credit_invoice.id)
    end

    test "delete_credit_invoice/1 deletes the credit_invoice" do
      credit_invoice = credit_invoice_fixture()
      assert {:ok, %CreditInvoice{}} = Cards.delete_credit_invoice(credit_invoice)
      assert_raise Ecto.NoResultsError, fn -> Cards.get_credit_invoice!(credit_invoice.id) end
    end

    test "change_credit_invoice/1 returns a credit_invoice changeset" do
      credit_invoice = credit_invoice_fixture()
      assert %Ecto.Changeset{} = Cards.change_credit_invoice(credit_invoice)
    end
  end

  describe "transactions" do
    alias App.Cards.Transaction

    @valid_attrs %{card_id: "some card_id", credit_invoice_id: "some credit_invoice_id", execute_at: "2010-04-17T14:00:00Z", executed: true, value: "120.5"}
    @update_attrs %{card_id: "some updated card_id", credit_invoice_id: "some updated credit_invoice_id", execute_at: "2011-05-18T15:01:01Z", executed: false, value: "456.7"}
    @invalid_attrs %{card_id: nil, credit_invoice_id: nil, execute_at: nil, executed: nil, value: nil}

    def transaction_fixture(attrs \\ %{}) do
      {:ok, transaction} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cards.create_transaction()

      transaction
    end

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Cards.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Cards.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      assert {:ok, %Transaction{} = transaction} = Cards.create_transaction(@valid_attrs)
      assert transaction.card_id == "some card_id"
      assert transaction.credit_invoice_id == "some credit_invoice_id"
      assert transaction.execute_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert transaction.executed == true
      assert transaction.value == Decimal.new("120.5")
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cards.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{} = transaction} = Cards.update_transaction(transaction, @update_attrs)
      assert transaction.card_id == "some updated card_id"
      assert transaction.credit_invoice_id == "some updated credit_invoice_id"
      assert transaction.execute_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert transaction.executed == false
      assert transaction.value == Decimal.new("456.7")
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Cards.update_transaction(transaction, @invalid_attrs)
      assert transaction == Cards.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Cards.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Cards.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Cards.change_transaction(transaction)
    end
  end
end
