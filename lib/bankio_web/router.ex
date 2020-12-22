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
		pipe_through :authenticated_user

		resources "/users", UserController, except: [:new, :edit]
		resources "/clients", ClientController, except: [:new, :edit]
		resources "/companies", CompanyController, except: [:new, :edit]

		# RECURO PARA CLIENTES DE EMPRESAS
		post "/company-clients", CompanyClientController, :create
		patch "/company-clients/:company_id/:client_id", CompanyClientController, :update
		delete "/company-clients/:company_id/:client_id", CompanyClientController, :delete

	end

	scope "/hello", AppWeb do
		pipe_through :api
		pipe_through :authenticated_client

		get "/", HelloController, :hello
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
