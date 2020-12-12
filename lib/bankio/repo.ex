defmodule App.Repo do
	use Ecto.Repo,
	    otp_app: :bankio,
	    adapter: Ecto.Adapters.MyXQL
end
