defmodule AppWeb.ClientView do
  use AppWeb, :view
  alias AppWeb.ClientView

  def companies(client, client_companies) do

    if is_list(client_companies) do
      Map.put(
        client,
        :companies,
        render_many(client_companies, AppWeb.CompanyClientView, "company_client.json")
      )

    else

      client

    end
  end

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
    |> companies(client.companies)
  end
end
