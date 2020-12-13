defmodule AppWeb.UserView do
  use AppWeb, :view
  alias AppWeb.UserView

  def render("index.json", %{users: users}) do
    render_many(users, UserView, "user.json")
  end

  def render("show.json", %{user: user}) do
    render_one(user, UserView, "user.json")
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      key: user.key,
      type: user.type,
      is_active: user.is_active
    }
  end
end
