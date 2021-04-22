defmodule MurderSheWrote.Episodes.Episode do
  use Ecto.Schema
  import Ecto.Changeset
  alias MurderSheWrote.Episodes.Season

  schema "episodes" do
    field :external_id, :integer
    field :number, :integer
    field :plot, :string
    field :poster, :string
    field :title, :string
    belongs_to :season, Season

    timestamps()
  end

  @doc false
  def changeset(episode, attrs) do
    episode
    |> cast(attrs, [:number, :external_id, :title, :plot, :poster])
    |> validate_required([:number, :external_id, :title, :plot, :poster])
  end
end
