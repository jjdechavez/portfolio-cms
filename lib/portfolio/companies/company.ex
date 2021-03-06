defmodule Portfolio.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset

  schema "companies" do
    field :location, :string
    field :name, :string
    field :url_link, :string
    field :active, :boolean
    field :user_id, :id

    timestamps()
  end

  @url ~r/https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()!@:%_\+.~#?&\/\/=]*)/

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name, :url_link, :location, :active])
    |> validate_required([:name, :url_link, :location, :active])
    |> validate_format(:url_link, @url, message: "must be a valid url link")
  end

  def create_changeset(company, attrs) do
    company
    |> cast(attrs, [:name, :url_link, :location, :user_id, :active])
    |> validate_required([:name, :url_link, :location, :user_id, :active])
  end
end
