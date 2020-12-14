# Script for populating the database. You can run it as:
#
# mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     App.Repo.insert!(%App.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# Seed USER Admin
App.Accounts.create_user(%{
  key: "qreidt",
  password: "Ab1234567890",
  type: App.Accounts.User.types[:administrator],
  is_active: true
})


# Seed Client User
App.Accounts.create_client(%{
  key: "qreidt",
  name: "Caio Reidt",
  password: "Ab1234567890",
  is_active: true
})
