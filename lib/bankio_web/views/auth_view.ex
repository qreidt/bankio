defmodule AppWeb.AuthView do
  use AppWeb, :view

  def render("user-token.json", %{token: token, user: user}) do
    %{
      token: token,
      user: render(AppWeb.UserView, "show.json", user: user)
    }
  end
end
