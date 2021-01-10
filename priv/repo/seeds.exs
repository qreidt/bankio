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

# Seed Admin User
{:ok, %App.Accounts.User{id: user_id}} = App.Accounts.create_user(%{
  key: "qreidt",
  name: "Caio Reidt",
  password: "Ab1234567890",
  type: App.Accounts.User.types[:administrator],
  is_active: true
})

# Seed User Token
App.Repo.insert!(%App.Accounts.UserToken{
  user_id: user_id,
  revoked: false,
  inserted_at: DateTime.utc_now |> DateTime.truncate(:second),
  id: "49f19306-f352-4477-994e-2b58fd1a1a3c"
})


# Seed Client User
{:ok, %App.Accounts.Client{id: client_id}} = App.Accounts.create_client(%{
  key: "461.700.428-93",
  name: "Caio Quincoses Reidt",
  password: "Ab1234567890",
  is_active: true
})


# Seed Company
{:ok, %App.Companies.Company{id: company_id}} = App.Companies.create_company(%{
  name: "Garnon Soluções e Serviços Em Tecnologia Ltda.",
  document: "26.003.654/0001-62",
  is_active: true
})

# Add Client to Company
App.Companies.create_company_client(%{
  company_id: company_id,
  client_id: client_id,
  since: DateTime.utc_now,
  until: nil
})


# Seed Agency
{:ok, %App.Agencies.Agency{id: agency_id}} = App.Agencies.create_agency(%{
  code: 1,
  name: "Agência 0001",
  is_active: true
})

# Add User to Agency
App.Agencies.create_agency_user(%{
  user_id: user_id,
  agency_id: agency_id,
  role: "Gerente",
  since: DateTime.utc_now,
  until: nil
})

# Seed Bank Account
{:ok, %App.Agencies.BankAccount{id: bank_account_id}} = App.Agencies.create_bank_account(%{
  agency_id: agency_id,
  code: 1,
  is_active: true,
  balance: 98765.4321,
  credit: 3400,
  since: DateTime.utc_now,
})

# Seed Bank Account Client
App.Agencies.create_bank_account_client(%{
  client_id: client_id,
  bank_account_id: bank_account_id,
  since: DateTime.utc_now,
})

# Seed Bank Account Card
{:ok, %App.Cards.Card{id: card_id}} = App.Cards.create_card(%{
  bank_account_id: bank_account_id,
  code: 1,
  password: "1234",
  is_active: true
})

# Seed Credit Invoice
{:ok, %App.Cards.CreditInvoice{id: credit_invoice_id}} = App.Cards.create_credit_invoice(%{
  card_id: card_id,
	balance: 100,
	reference_month: "2021-02",
	status: 1,
	started: "2021-02-01T00:00:00.000Z",
	ended: "2021-02-28T00:00:00.000Z",
	interest: 0
})

# Seed Normal Transaction
App.Cards.create_transaction(%{
  card_id: card_id,
  value: 100.999,
  executed: true
})

# Seed Credit Transaction
App.Cards.create_transaction(%{
  card_id: card_id,
  credit_invoice_id: credit_invoice_id,
  value: 100.999,
  executed: true
})

# Seed Scheduled Transaction
App.Cards.create_transaction(%{
  card_id: card_id,
  value: 100.999,
  executed: false,
  execute_at: "2021-02-12T09:30:00.000Z"
})
