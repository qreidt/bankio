defmodule AppWeb.HelloController do
  use AppWeb, :controller

  def hello(conn, _params) do
    user = conn.assigns[:signed_user]

    conn
    |> put_status(:ok)
    |> render("hello.json", key: user.key)

  end
end
