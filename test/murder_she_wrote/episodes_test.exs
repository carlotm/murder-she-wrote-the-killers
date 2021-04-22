defmodule MurderSheWrote.EpisodesTest do
  use MurderSheWrote.DataCase

  alias MurderSheWrote.Episodes

  describe "seasons" do
    alias MurderSheWrote.Episodes.Season

    @valid_attrs %{external_id: 42, number: 42}
    @update_attrs %{external_id: 43, number: 43}
    @invalid_attrs %{external_id: nil, number: nil}

    def season_fixture(attrs \\ %{}) do
      {:ok, season} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Episodes.create_season()

      season
    end

    test "list_seasons/0 returns all seasons" do
      season = season_fixture()
      assert Episodes.list_seasons() == [season]
    end

    test "get_season!/1 returns the season with given id" do
      season = season_fixture()
      assert Episodes.get_season!(season.id) == season
    end

    test "create_season/1 with valid data creates a season" do
      assert {:ok, %Season{} = season} = Episodes.create_season(@valid_attrs)
      assert season.external_id == 42
      assert season.number == 42
    end

    test "create_season/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Episodes.create_season(@invalid_attrs)
    end

    test "update_season/2 with valid data updates the season" do
      season = season_fixture()
      assert {:ok, %Season{} = season} = Episodes.update_season(season, @update_attrs)
      assert season.external_id == 43
      assert season.number == 43
    end

    test "update_season/2 with invalid data returns error changeset" do
      season = season_fixture()
      assert {:error, %Ecto.Changeset{}} = Episodes.update_season(season, @invalid_attrs)
      assert season == Episodes.get_season!(season.id)
    end

    test "delete_season/1 deletes the season" do
      season = season_fixture()
      assert {:ok, %Season{}} = Episodes.delete_season(season)
      assert_raise Ecto.NoResultsError, fn -> Episodes.get_season!(season.id) end
    end

    test "change_season/1 returns a season changeset" do
      season = season_fixture()
      assert %Ecto.Changeset{} = Episodes.change_season(season)
    end
  end

  describe "episodes" do
    alias MurderSheWrote.Episodes.Episode

    @valid_attrs %{external_id: 42, number: 42, plot: "some plot", poster: "some poster", title: "some title"}
    @update_attrs %{external_id: 43, number: 43, plot: "some updated plot", poster: "some updated poster", title: "some updated title"}
    @invalid_attrs %{external_id: nil, number: nil, plot: nil, poster: nil, title: nil}

    def episode_fixture(attrs \\ %{}) do
      {:ok, episode} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Episodes.create_episode()

      episode
    end

    test "list_episodes/0 returns all episodes" do
      episode = episode_fixture()
      assert Episodes.list_episodes() == [episode]
    end

    test "get_episode!/1 returns the episode with given id" do
      episode = episode_fixture()
      assert Episodes.get_episode!(episode.id) == episode
    end

    test "create_episode/1 with valid data creates a episode" do
      assert {:ok, %Episode{} = episode} = Episodes.create_episode(@valid_attrs)
      assert episode.external_id == 42
      assert episode.number == 42
      assert episode.plot == "some plot"
      assert episode.poster == "some poster"
      assert episode.title == "some title"
    end

    test "create_episode/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Episodes.create_episode(@invalid_attrs)
    end

    test "update_episode/2 with valid data updates the episode" do
      episode = episode_fixture()
      assert {:ok, %Episode{} = episode} = Episodes.update_episode(episode, @update_attrs)
      assert episode.external_id == 43
      assert episode.number == 43
      assert episode.plot == "some updated plot"
      assert episode.poster == "some updated poster"
      assert episode.title == "some updated title"
    end

    test "update_episode/2 with invalid data returns error changeset" do
      episode = episode_fixture()
      assert {:error, %Ecto.Changeset{}} = Episodes.update_episode(episode, @invalid_attrs)
      assert episode == Episodes.get_episode!(episode.id)
    end

    test "delete_episode/1 deletes the episode" do
      episode = episode_fixture()
      assert {:ok, %Episode{}} = Episodes.delete_episode(episode)
      assert_raise Ecto.NoResultsError, fn -> Episodes.get_episode!(episode.id) end
    end

    test "change_episode/1 returns a episode changeset" do
      episode = episode_fixture()
      assert %Ecto.Changeset{} = Episodes.change_episode(episode)
    end
  end

  describe "killers" do
    alias MurderSheWrote.Episodes.Killer

    @valid_attrs %{name: "some name", picture: "some picture", picture64: "some picture64"}
    @update_attrs %{name: "some updated name", picture: "some updated picture", picture64: "some updated picture64"}
    @invalid_attrs %{name: nil, picture: nil, picture64: nil}

    def killer_fixture(attrs \\ %{}) do
      {:ok, killer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Episodes.create_killer()

      killer
    end

    test "list_killers/0 returns all killers" do
      killer = killer_fixture()
      assert Episodes.list_killers() == [killer]
    end

    test "get_killer!/1 returns the killer with given id" do
      killer = killer_fixture()
      assert Episodes.get_killer!(killer.id) == killer
    end

    test "create_killer/1 with valid data creates a killer" do
      assert {:ok, %Killer{} = killer} = Episodes.create_killer(@valid_attrs)
      assert killer.name == "some name"
      assert killer.picture == "some picture"
      assert killer.picture64 == "some picture64"
    end

    test "create_killer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Episodes.create_killer(@invalid_attrs)
    end

    test "update_killer/2 with valid data updates the killer" do
      killer = killer_fixture()
      assert {:ok, %Killer{} = killer} = Episodes.update_killer(killer, @update_attrs)
      assert killer.name == "some updated name"
      assert killer.picture == "some updated picture"
      assert killer.picture64 == "some updated picture64"
    end

    test "update_killer/2 with invalid data returns error changeset" do
      killer = killer_fixture()
      assert {:error, %Ecto.Changeset{}} = Episodes.update_killer(killer, @invalid_attrs)
      assert killer == Episodes.get_killer!(killer.id)
    end

    test "delete_killer/1 deletes the killer" do
      killer = killer_fixture()
      assert {:ok, %Killer{}} = Episodes.delete_killer(killer)
      assert_raise Ecto.NoResultsError, fn -> Episodes.get_killer!(killer.id) end
    end

    test "change_killer/1 returns a killer changeset" do
      killer = killer_fixture()
      assert %Ecto.Changeset{} = Episodes.change_killer(killer)
    end
  end
end
