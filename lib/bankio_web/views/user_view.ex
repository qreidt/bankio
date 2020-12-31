defmodule AppWeb.UserView do
  use AppWeb, :view
  alias AppWeb.UserView

  def user(user) do
    %{
      id: user.id,
      name: user.name,
      key: user.key,
      type: user.type,
      is_active: user.is_active
    }
  end

  def agencies(user, agency_users) do
    if is_list(agency_users) do
      Map.put(
        user,
        :agencies,
        render_many(agency_users, AppWeb.AgencyUserView, "agency-user.json")
      )

    else

      user

    end
  end

  def render("index.json", %{users: users}) do
    render_many(users, UserView, "user.json")
  end

  def render("show.json", %{user: user}) do
    render_one(user, UserView, "user.json")
  end

  def render("user.json", %{user: user}) do

    user
    |> AppWeb.UserView.user
    |> AppWeb.UserView.agencies(user.agencies)

  end
end
