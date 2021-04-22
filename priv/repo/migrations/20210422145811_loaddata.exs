defmodule MurderSheWrote.Repo.Migrations.Loadepisodes do
  use Ecto.Migration

  @root_dir File.cwd!()
  @data_dir Path.join(@root_dir, "priv/data")

  @seasons_data Path.join(@data_dir, "seasons.csv")
  @episodes_data Path.join(@data_dir, "episodes.csv")
  @killers_data Path.join(@data_dir, "killers.csv")

  @fixtures [
    {@seasons_data, "seasons", "id, number, external_id, inserted_at, updated_at"},
    {@episodes_data, "episodes",
     "id, number, external_id, title, plot, poster, season_id, inserted_at, updated_at"},
    {@killers_data, "killers",
     "id, name, episode_id, picture, picture64, inserted_at, updated_at"}
  ]

  def change,
    do:
      Enum.each(
        @fixtures,
        fn {file, table, columns} -> copy_from(file, table, columns) end
      )

  defp copy_from(file, table, columns) do
    case MurderSheWrote.Repo.query(
           "COPY #{table} (#{columns}) FROM '#{file}' WITH (FORMAT csv, HEADER True)"
         ) do
      {:ok, _} ->
        IO.puts("#{table} LOADED.")

      {:error, %{postgres: %{message: message}}} ->
        IO.puts("#{table} NOT LOADED WITH ERROR:\n#{message}")
    end
  end
end
