defmodule Urlbot.Links.Link do
  use Ecto.Schema
  import Ecto.Changeset
  alias Urlbot.Ecto.HashId

  @primary_key {:hash, HashId, [autogenerate: true]}
  @derive {Phoenix.Param, key: :hash}

  schema "links" do
    field :url, :string
    field :visits, :integer
    field :account_id, :id

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:url, :visits, :account_id])
    |> validate_required([:url, :visits, :account_id])
  end
end
