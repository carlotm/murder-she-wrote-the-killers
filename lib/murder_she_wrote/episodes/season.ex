defmodule MurderSheWrote.Episodes.Season do
  use Ecto.Schema
  import Ecto.Changeset

  schema "seasons" do
    field :external_id, :integer
    field :number, :integer

    timestamps()
  end

  @doc false
  def changeset(season, attrs) do
    season
    |> cast(attrs, [:number, :external_id])
    |> validate_required([:number, :external_id])
  end
end
