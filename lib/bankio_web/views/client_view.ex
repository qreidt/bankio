defmodule AppWeb.ClientView do
  use AppWeb, :view
  alias AppWeb.ClientView

  def render("index.json", %{clients: clients}) do
    render_many(clients, ClientView, "client.json")
  end

  def render("show.json", %{client: client}) do
    render_one(client, ClientView, "client.json")
  end

  def render("client.json", %{client: client}) do
    %{
      id: client.id,
      name: client.name,
      key: client.key,
      is_active: client.is_active
    }
  end
end
