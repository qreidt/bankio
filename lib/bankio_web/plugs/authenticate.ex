defmodule AppWeb.Plugs.Authenticate do

  import Plug.Conn
  import Phoenix.Controller

  def init(default), do: default

  def call(conn, _default) do
    case App.Services.Authenticator.get_token("user", conn) do

      {:ok, token} ->

        user_token = App.Repo.get_by(App.Accounts.UserToken, [id: token, revoked: false])
        |> App.Repo.preload(:user)

        case user_token do

          nil -> unauthorized(conn)

          user_token -> authorized(conn, user_token.user)

        end

      # end {:ok, token} case

      _ -> unauthorized(conn)

    end
  end

  defp authorized(conn, user) do
    # If you want, add new values to `conn`
    conn
    |> assign(:signed_in, true)
    |> assign(:signed_user, user)
  end

  defp unauthorized(conn) do
    conn
    |> put_status(401)
    |> put_view(AppWeb.ErrorView)
    |> render("401.json", %{message: "Unauthorized"})
    |> halt()
  end

end
