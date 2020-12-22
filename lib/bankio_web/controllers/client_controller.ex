defmodule AppWeb.ClientController do
  use AppWeb, :controller

  alias App.Accounts
  alias App.Accounts.Client

  action_fallback AppWeb.FallbackController

  def index(conn, _params) do
    clients = Accounts.list_clients()
    render(conn, "index.json", clients: clients)
  end

  def create(conn, params) do
    with {:ok, %Client{} = client} <- Accounts.create_client(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.client_path(conn, :show, client))
      |> render("show.json", client: client)
    end
  end

  def show(conn, %{"id" => id}) do
    client = Accounts.get_client!(id, [:companies])
    render(conn, "show.json", client: client)
  end

  def update(conn, %{"id" => id} = params) do
    client = Accounts.get_client!(id)

    with {:ok, %Client{} = client} <- Accounts.update_client(client, params) do
      render(conn, "show.json", client: client)
    end
  end

  def delete(conn, %{"id" => id}) do
    client = Accounts.get_client!(id)

    with {:ok, %Client{}} <- Accounts.delete_client(client) do
      send_resp(conn, :no_content, "")
    end
  end
end
