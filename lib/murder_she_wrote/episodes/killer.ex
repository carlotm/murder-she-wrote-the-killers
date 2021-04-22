defmodule MurderSheWrote.Episodes.Killer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "killers" do
    field :name, :string
    field :picture, :string
    field :picture64, :string
    field :episode_id, :id

    timestamps()
  end

  @doc false
  def changeset(killer, attrs) do
    killer
    |> cast(attrs, [:name, :picture, :picture64])
    |> validate_required([:name, :picture, :picture64])
  end
end
