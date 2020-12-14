defmodule AppWeb.Router do
	use AppWeb, :router

	pipeline :api do
		plug :accepts, ["json"]
	end

	pipeline :authenticated_user do
		plug AppWeb.Plugs.AuthenticatedUser
	end

	pipeline :authenticated_client do
		plug AppWeb.Plugs.AuthenticatedClient
	end

	scope "/", AppWeb do
		pipe_through :api
		pipe_through :authenticated_client

		get "/hello", HelloController, :hello
	end

	scope "/user", AppWeb do
		pipe_through :api

		post "/login", AuthController, :user_login
		delete "/logout", AuthController, :user_logout
	end

	scope "/client", AppWeb do
		pipe_through :api

		post "/login", AuthController, :client_login
		delete "/logout", AuthController, :client_logout
	end
end
