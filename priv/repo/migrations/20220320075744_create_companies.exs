defmodule Portfolio.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add(:name, :string)
      add(:url_link, :string)
      add(:location, :string)
      add(:active, :boolean)
      add(:user_id, references(:users, on_delete: :delete_all))

      timestamps()
    end

    create(index(:companies, [:user_id]))
  end
end
