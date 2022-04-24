defmodule Portfolio.Experciences.Expercience do
  use Ecto.Schema
  import Ecto.Changeset

  schema "experciences" do
    field :name, :string
    field :current_work, :boolean, default: false
    field :end_date, :date
    field :start_date, :date
    field :active, :boolean, default: false
    field :company_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(expercience, attrs) do
    expercience
    |> cast(attrs, [:name, :start_date, :end_date, :current_work, :active])
    |> validate_required([:name, :start_date, :current_work, :active])
  end

  def create_changeset(expercience, attrs) do
    expercience
    |> cast(attrs, [:name, :start_date, :end_date, :current_work, :active, :user_id, :company_id])
    |> validate_required([:name, :start_date, :current_work, :active, :user_id, :company_id])
  end
end
