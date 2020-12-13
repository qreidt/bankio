defmodule App.Services.Authenticator do

  def generate_token(namespace, user) do
    token = App.Repo.insert!(Ecto.build_assoc(user, :tokens))
    Phoenix.Token.sign(AppWeb.Endpoint, namespace, token.id)
  end

  def verify_token(namespace, token) do

    case Phoenix.Token.verify(AppWeb.Endpoint, namespace, token) do

      {:ok, id} -> {:ok, id}

      error -> error

    end

  end

  def get_token(namespace, conn) do

    case extract_token(conn) do
      {:ok, token} ->
        verify_token(namespace, token)

      error -> error
    end

  end


  defp extract_token(conn) do

    case Plug.Conn.get_req_header(conn, "authorization") do

      [auth_header] -> get_token_from_header(auth_header)

       _ -> {:error, :missing_auth_header}
    end

  end


  defp get_token_from_header(auth_header) do

    {:ok, reg} = Regex.compile("Bearer\:?\s+(.*)$", "i")

    case Regex.run(reg, auth_header) do
      [_, match] -> {:ok, String.trim(match)}
      _ -> {:error, "token not found"}
    end

  end



end
