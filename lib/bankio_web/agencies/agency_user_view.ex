defmodule AppWeb.AgencyUserView do
  use AppWeb, :view
  alias AppWeb.AgencyUserView

  def agency_user(agency_user) do
    %{
      user_id: agency_user.user_id,
      agency_id: agency_user.agency_id,
      role: agency_user.role,
      since: agency_user.since,
      until: agency_user.until,
      inserted_at: agency_user.inserted_at,
      updated_at: agency_user.updated_at
    }
  end

  def agency(agency_user, agency) do
    case agency do
      %App.Agencies.Agency{} ->
        Map.put(agency_user, :agency, render_one(agency, AppWeb.AgencyView, "agency.json"))
        |> Map.delete(:agency_id)

      _ -> agency_user
    end
  end

  def user(agency_user, user) do
    case user do
      %App.Accounts.User{} ->
        Map.put(agency_user, :user, render_one(user, AppWeb.UserView, "user.json"))
        |> Map.delete(:user_id)

      _ -> agency_user
    end
  end

  def render("index.json", %{agency_users: agency_users}) do
    render_many(agency_users, AgencyUserView, "agency-user.json")
  end

  def render("show.json", %{agency_user: agency_user}) do
    render_one(agency_user, AgencyUserView, "agency-user.json")
  end

  def render("agency-user.json", %{agency_user: agency_user}) do
    agency_user
    |> AgencyUserView.agency_user
    |> AgencyUserView.agency(agency_user.agency)
    |> AgencyUserView.user(agency_user.user)
  end
end
