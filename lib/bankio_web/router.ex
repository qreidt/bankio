defmodule AppWeb.Router do
	use AppWeb, :router

	pipeline :api do
		plug :accepts, ["json"]
	end

	pipeline :authenticated do
		plug AppWeb.Plugs.Authenticate
	end

	scope "/", AppWeb do
		pipe_through :api
		pipe_through :authenticated

		get "/hello", HelloController, :hello
	end

	scope "/user", AppWeb do
		pipe_through :api

		post "/login", AuthController, :user_login
		delete "/logout", AuthController, :user_logout
	end
end
