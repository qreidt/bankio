defmodule AppWeb.Endpoint do
	use Phoenix.Endpoint, otp_app: :bankio

	# socket "/socket",
	#        AppWeb.UserSocket,
	#        websocket: true,
	#        longpoll: false

	# Serve at "/" the static files from "priv/static" directory.
	#
	# You should set gzip to true if you are running phx.digest
	# when deploying your static files in production.
	# plug Plug.Static,
	#      at: "/",
	#      from: :bankio,
	#      gzip: false,
	#      only: ~w(css fonts images js favicon.ico robots.txt)

	# Code reloading can be explicitly enabled under the
	# :code_reloader configuration of your endpoint.
	if code_reloading? do
		plug Phoenix.CodeReloader
		plug Phoenix.Ecto.CheckRepoStatus, otp_app: :bankio
	end

	plug Plug.RequestId

	plug Plug.Parsers,
	     parsers: [:urlencoded, :multipart, :json],
	     pass: ["*/*"],
	     json_decoder: Phoenix.json_library()

	plug Plug.MethodOverride
	plug Plug.Head
	plug AppWeb.Router
end
