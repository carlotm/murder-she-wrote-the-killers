defmodule MurderSheWrote.Repo.Migrations.CreateEpisodes do
  use Ecto.Migration

  def change do
    create table(:episodes) do
      add(:number, :integer)
      add(:external_id, :integer)
      add(:title, :string)
      add(:plot, :text)
      add(:poster, :string)
      add(:season_id, references(:seasons, on_delete: :nothing))

      timestamps()
    end

    create(index(:episodes, [:season_id]))
  end
end
