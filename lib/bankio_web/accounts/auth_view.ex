defmodule AppWeb.AuthView do
  use AppWeb, :view

  def render("user-token.json", %{token: token, user: user}) do
    %{
      token: token,
      user: render(AppWeb.UserView, "show.json", user: user)
    }
  end

  def render("client-token.json", %{token: token, client: client}) do
    %{
      token: token,
      client: render(AppWeb.ClientView, "show.json", client: client)
    }
  end
end
