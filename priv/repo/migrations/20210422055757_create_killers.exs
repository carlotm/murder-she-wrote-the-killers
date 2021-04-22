defmodule MurderSheWrote.Repo.Migrations.CreateKillers do
  use Ecto.Migration

  def change do
    create table(:killers) do
      add(:name, :string)
      add(:picture, :string)
      add(:picture64, :text)
      add(:episode_id, references(:episodes, on_delete: :nothing))

      timestamps()
    end
  end
end
