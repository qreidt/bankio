defmodule AppWeb.CreditInvoiceControllerTest do
  use AppWeb.ConnCase

  alias App.Cards
  alias App.Cards.CreditInvoice

  @create_attrs %{
    balance: "120.5",
    card_id: "some card_id",
    ended: "2010-04-17T14:00:00Z",
    interest: "120.5",
    paid_at: "2010-04-17T14:00:00Z",
    reference_month: ~D[2010-04-17],
    started: "2010-04-17T14:00:00Z",
    status: 42
  }
  @update_attrs %{
    balance: "456.7",
    card_id: "some updated card_id",
    ended: "2011-05-18T15:01:01Z",
    interest: "456.7",
    paid_at: "2011-05-18T15:01:01Z",
    reference_month: ~D[2011-05-18],
    started: "2011-05-18T15:01:01Z",
    status: 43
  }
  @invalid_attrs %{balance: nil, card_id: nil, ended: nil, interest: nil, paid_at: nil, reference_month: nil, started: nil, status: nil}

  def fixture(:credit_invoice) do
    {:ok, credit_invoice} = Cards.create_credit_invoice(@create_attrs)
    credit_invoice
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all credit_invoices", %{conn: conn} do
      conn = get(conn, Routes.credit_invoice_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create credit_invoice" do
    test "renders credit_invoice when data is valid", %{conn: conn} do
      conn = post(conn, Routes.credit_invoice_path(conn, :create), credit_invoice: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.credit_invoice_path(conn, :show, id))

      assert %{
               "id" => id,
               "balance" => "120.5",
               "card_id" => "some card_id",
               "ended" => "2010-04-17T14:00:00Z",
               "interest" => "120.5",
               "paid_at" => "2010-04-17T14:00:00Z",
               "reference_month" => "2010-04-17",
               "started" => "2010-04-17T14:00:00Z",
               "status" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.credit_invoice_path(conn, :create), credit_invoice: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update credit_invoice" do
    setup [:create_credit_invoice]

    test "renders credit_invoice when data is valid", %{conn: conn, credit_invoice: %CreditInvoice{id: id} = credit_invoice} do
      conn = put(conn, Routes.credit_invoice_path(conn, :update, credit_invoice), credit_invoice: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.credit_invoice_path(conn, :show, id))

      assert %{
               "id" => id,
               "balance" => "456.7",
               "card_id" => "some updated card_id",
               "ended" => "2011-05-18T15:01:01Z",
               "interest" => "456.7",
               "paid_at" => "2011-05-18T15:01:01Z",
               "reference_month" => "2011-05-18",
               "started" => "2011-05-18T15:01:01Z",
               "status" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, credit_invoice: credit_invoice} do
      conn = put(conn, Routes.credit_invoice_path(conn, :update, credit_invoice), credit_invoice: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete credit_invoice" do
    setup [:create_credit_invoice]

    test "deletes chosen credit_invoice", %{conn: conn, credit_invoice: credit_invoice} do
      conn = delete(conn, Routes.credit_invoice_path(conn, :delete, credit_invoice))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.credit_invoice_path(conn, :show, credit_invoice))
      end
    end
  end

  defp create_credit_invoice(_) do
    credit_invoice = fixture(:credit_invoice)
    %{credit_invoice: credit_invoice}
  end
end
