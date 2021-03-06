defmodule AppWeb.CardControllerTest do
  use AppWeb.ConnCase

  alias App.Cards
  alias App.Cards.Card

  @create_attrs %{
    balance: "120.5",
    bank_account_id: "some bank_account_id",
    code: 42,
    is_active: true,
    password: "some password"
  }
  @update_attrs %{
    balance: "456.7",
    bank_account_id: "some updated bank_account_id",
    code: 43,
    is_active: false,
    password: "some updated password"
  }
  @invalid_attrs %{balance: nil, bank_account_id: nil, code: nil, is_active: nil, password: nil}

  def fixture(:card) do
    {:ok, card} = Cards.create_card(@create_attrs)
    card
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all cards", %{conn: conn} do
      conn = get(conn, Routes.card_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create card" do
    test "renders card when data is valid", %{conn: conn} do
      conn = post(conn, Routes.card_path(conn, :create), card: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.card_path(conn, :show, id))

      assert %{
               "id" => id,
               "balance" => "120.5",
               "bank_account_id" => "some bank_account_id",
               "code" => 42,
               "is_active" => true,
               "password" => "some password"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.card_path(conn, :create), card: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update card" do
    setup [:create_card]

    test "renders card when data is valid", %{conn: conn, card: %Card{id: id} = card} do
      conn = put(conn, Routes.card_path(conn, :update, card), card: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.card_path(conn, :show, id))

      assert %{
               "id" => id,
               "balance" => "456.7",
               "bank_account_id" => "some updated bank_account_id",
               "code" => 43,
               "is_active" => false,
               "password" => "some updated password"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, card: card} do
      conn = put(conn, Routes.card_path(conn, :update, card), card: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete card" do
    setup [:create_card]

    test "deletes chosen card", %{conn: conn, card: card} do
      conn = delete(conn, Routes.card_path(conn, :delete, card))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.card_path(conn, :show, card))
      end
    end
  end

  defp create_card(_) do
    card = fixture(:card)
    %{card: card}
  end
end
