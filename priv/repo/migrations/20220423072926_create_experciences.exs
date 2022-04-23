defmodule Portfolio.Repo.Migrations.CreateExperciences do
  use Ecto.Migration

  def change do
    create table(:experciences) do
      add(:name, :string, null: false)
      add(:start_date, :date, null: false)
      add(:end_date, :date)
      add(:current_work, :boolean, default: false, null: false)
      add(:active, :boolean, default: false, null: true)
      add(:company_id, references(:companies, on_delete: :delete_all))
      add(:user_id, references(:users, on_delete: :delete_all))

      timestamps()
    end

    create(index(:experciences, [:company_id]))
    create(index(:experciences, [:user_id]))
  end
end
