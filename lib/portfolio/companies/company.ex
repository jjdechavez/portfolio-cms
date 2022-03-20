defmodule Portfolio.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset

  schema "companies" do
    field :location, :string
    field :name, :string
    field :url_link, :string

    timestamps()
  end

  @url ~r/https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()!@:%_\+.~#?&\/\/=]*)/

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name, :url_link, :location])
    |> validate_required([:name, :url_link, :location])
    |> validate_format(:url_link, @url, message: "must be a valid url link")
  end
end
