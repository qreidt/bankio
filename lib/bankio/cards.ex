defmodule App.Cards do
  @moduledoc """
  The Cards context.
  """

  import Ecto.Query, warn: false
  alias App.Repo

  alias App.Agencies.BankAccount
  alias App.Cards.{Card, CreditInvoice, Transaction}

  @doc """
  Returns the list of cards.

  ## Examples

      iex> list_cards()
      [%Card{}, ...]

  """
  def list_cards do
    Repo.all(Card)
  end

  @doc """
  Gets a single card.

  Raises `Ecto.NoResultsError` if the Card does not exist.

  ## Examples

      iex> get_card!(123)
      %Card{}

      iex> get_card!(456)
      ** (Ecto.NoResultsError)

  """
  def get_card!(id), do: Repo.get!(Card, id)
  def get_card!(id, :complete) do
    Repo.get!(Card, id)
    |> Repo.preload(:bank_account)
    |> IO.inspect
  end

  @doc """
  Creates a card.

  ## Examples

      iex> create_card(%{field: value})
      {:ok, %Card{}}

      iex> create_card(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_card(attrs \\ %{}) do
    %Card{}
    |> Card.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a card.

  ## Examples

      iex> update_card(card, %{field: new_value})
      {:ok, %Card{}}

      iex> update_card(card, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_card(%Card{} = card, attrs) do
    card
    |> Card.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a card.

  ## Examples

      iex> delete_card(card)
      {:ok, %Card{}}

      iex> delete_card(card)
      {:error, %Ecto.Changeset{}}

  """
  def delete_card(%Card{} = card) do
    Repo.delete(card)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking card changes.

  ## Examples

      iex> change_card(card)
      %Ecto.Changeset{data: %Card{}}

  """
  def change_card(%Card{} = card, attrs \\ %{}) do
    Card.changeset(card, attrs)
  end


  @doc """
  Returns the list of credit_invoices.

  ## Examples

      iex> list_credit_invoices()
      [%CreditInvoice{}, ...]

  """
  def list_credit_invoices, do: Repo.all(CreditInvoice)
  def list_credit_invoices(card_id) do
    Repo.all(
      from credit_invoice in CreditInvoice,
      where: credit_invoice.card_id == ^card_id
    )
  end

  @doc """
  Gets a single credit_invoice.

  Raises `Ecto.NoResultsError` if the Credit invoice does not exist.

  ## Examples

      iex> get_credit_invoice!(123)
      %CreditInvoice{}

      iex> get_credit_invoice!(456)
      ** (Ecto.NoResultsError)

  """
  def get_credit_invoice!(id), do: Repo.get!(CreditInvoice, id)
  def get_credit_invoice!(id, :complete) do
    Repo.get!(CreditInvoice, id)
    |> Repo.preload(:card)
  end

  @doc """
  Creates a credit_invoice.

  ## Examples

      iex> create_credit_invoice(%{field: value})
      {:ok, %CreditInvoice{}}

      iex> create_credit_invoice(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_credit_invoice(attrs \\ %{}) do
    %CreditInvoice{}
    |> CreditInvoice.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a credit_invoice.

  ## Examples

      iex> update_credit_invoice(credit_invoice, %{field: new_value})
      {:ok, %CreditInvoice{}}

      iex> update_credit_invoice(credit_invoice, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_credit_invoice(%CreditInvoice{} = credit_invoice, attrs) do
    credit_invoice
    |> CreditInvoice.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a credit_invoice.

  ## Examples

      iex> delete_credit_invoice(credit_invoice)
      {:ok, %CreditInvoice{}}

      iex> delete_credit_invoice(credit_invoice)
      {:error, %Ecto.Changeset{}}

  """
  def delete_credit_invoice(%CreditInvoice{} = credit_invoice) do
    Repo.delete(credit_invoice)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking credit_invoice changes.

  ## Examples

      iex> change_credit_invoice(credit_invoice)
      %Ecto.Changeset{data: %CreditInvoice{}}

  """
  def change_credit_invoice(%CreditInvoice{} = credit_invoice, attrs \\ %{}) do
    CreditInvoice.changeset(credit_invoice, attrs)
  end


  @doc """
  Returns the list of transactions.

  ## Examples

      iex> list_transactions()
      [%Transaction{}, ...]

  """
  def list_transactions do
    Repo.all(Transaction)
  end

  @doc """
  Gets a single transaction.

  Raises `Ecto.NoResultsError` if the Transaction does not exist.

  ## Examples

      iex> get_transaction!(123)
      %Transaction{}

      iex> get_transaction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transaction!(id), do: Repo.get!(Transaction, id)
  def get_transaction!(id, :complete) do
    Repo.get!(Transaction, id)
    |> Repo.preload(:credit_invoice)
    |> Repo.preload(:card)
  end

  @doc """
  Creates a transaction.

  ## Examples

      iex> create_transaction(%{field: value})
      {:ok, %Transaction{}}

      iex> create_transaction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transaction(attrs \\ %{}) do
    transaction_changeset = %Transaction{}
    |> Transaction.changeset(attrs)

    case transaction_changeset do
      # caso os dados enviados não sejam validos
      %Ecto.Changeset{valid?: false} ->
        {:error, transaction_changeset}

      # tudo certo
      _ ->
        %{
          card_id: transaction_card_id,
          value: transaction_value
        } = transaction_changeset.changes

        %Card{bank_account: bank_account} = Repo.get!(Card, transaction_card_id)
        |> Repo.preload(:bank_account)

        bank_account_changeset = BankAccount.update_changeset(
          bank_account,
          %{balance: Decimal.add(bank_account.balance, transaction_value)}
        )

        Repo.transaction(fn ->
          Repo.update!(bank_account_changeset)
          Repo.insert!(transaction_changeset)
        end)
    end
  end

  @doc """
  Updates a transaction.

  ## Examples

      iex> update_transaction(transaction, %{field: new_value})
      {:ok, %Transaction{}}

      iex> update_transaction(transaction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transaction(%Transaction{} = transaction, attrs) do
    transaction_changeset = transaction
    |> Transaction.update_changeset(attrs)

    case transaction_changeset do
      
      # caso os dados enviados não sejam validos
      %Ecto.Changeset{valid?: false} ->
        {:error, transaction_changeset}

      # caso esteja atualizando o valor da transação
      %Ecto.Changeset{valid?: true, changes: %{value: value}} ->
        %Card{bank_account: bank_account} = Repo.get!(Card, transaction.card_id)
        |> Repo.preload(:bank_account)

        new_balance =
          bank_account.balance
          |> Decimal.add(transaction.value)
          |> Decimal.sub(Decimal.new(value))

        bank_account_changeset = BankAccount.update_changeset(
          bank_account,
          %{balance: new_balance}
        )

        Repo.transaction(fn ->
          Repo.update!(bank_account_changeset)
          Repo.update!(transaction_changeset)
        end)

      # caso esteja atualizando outras informações da transação
      _ ->
        Repo.update(transaction_changeset)
    end
  end

  @doc """
  Deletes a transaction.

  ## Examples

      iex> delete_transaction(transaction)
      {:ok, %Transaction{}}

      iex> delete_transaction(transaction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transaction(%Transaction{} = transaction) do
    Repo.delete(transaction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transaction changes.

  ## Examples

      iex> change_transaction(transaction)
      %Ecto.Changeset{data: %Transaction{}}

  """
  def change_transaction(%Transaction{} = transaction, attrs \\ %{}) do
    Transaction.changeset(transaction, attrs)
  end
end
