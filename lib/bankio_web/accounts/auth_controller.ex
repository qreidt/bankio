defmodule AppWeb.AuthController do

  use AppWeb, :controller
  alias App.Accounts

  def user_login(conn, params) do

    case params do

      %{"key" => key, "password" => password} ->
        case Accounts.login(:user, key, password) do

          {:ok, user, token} ->

            conn
            |> put_status(:ok)
            |> render("user-token.json", user: user, token: token)

          {:error, _reason} ->

            conn
            |> put_status(401)
            |> put_view(AppWeb.ErrorView)
            |> render("401.json", message: "Key and Password Combination don't match")

        end

      _bad_request ->

        conn
        |> put_status(422)
        |> put_view(AppWeb.ErrorView)
        |> render("422.json")

    end

  end

  def client_login(conn, params) do

    case params do

      %{"key" => key, "password" => password} ->
        case Accounts.login(:user, key, password) do

          {:ok, user, token} ->
            conn
            |> put_status(:ok)
            |> render("user-token.json", user: user, token: token)

          {:error, _reason} ->

            conn
            |> put_status(401)
            |> put_view(AppWeb.ErrorView)
            |> render("401.json", message: "Key and Password Combination don't match")

        end

      _bad_request ->

        conn
        |> put_status(422)
        |> put_view(AppWeb.ErrorView)
        |> render("422.json")

    end

  end


  def user_logout(conn, _) do

    case Accounts.logout(:user, conn) do

      {:ok, _} ->

        conn
        |> send_resp(204, "")

      {:error, reason} ->

        conn
        |> send_resp(400, reason)

    end

  end

  def client_logout(conn, _) do

    case Accounts.logout(:client, conn) do

      {:ok, _} ->

        conn
        |> send_resp(204, "")

      {:error, reason} ->
        
        conn
        |> send_resp(400, reason)

    end

  end

end
