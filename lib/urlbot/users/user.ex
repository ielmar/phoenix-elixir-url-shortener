defmodule Urlbot.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  import Ecto.Changeset

  alias Urlbot.Accounts

  schema "users" do
    pow_user_fields()

    field :account_name, :string, virtual: true

    belongs_to :account, Urlbot.Accounts.Account

    timestamps()
  end

    def changeset(user, attrs) do
    user
    |> pow_changeset(attrs)
    |> cast(attrs, [:account_name])
    |> validate_required([:account_name])
    |> create_user_account(user)
    |> assoc_constraint(:account)
    end

    defp create_user_account(%{valid?: true,  changes: %{account_name: account_name}} = changeset, %{account_id: nil} = _user) do
    with {:ok, account} <- Accounts.create_account(%{name: account_name}) do
      put_assoc(changeset, :account, account)
    else
      _ -> changeset
    end
  end

  defp create_user_account(changeset, _), do: changeset
end
