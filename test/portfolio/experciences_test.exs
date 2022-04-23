defmodule Portfolio.ExperciencesTest do
  use Portfolio.DataCase

  alias Portfolio.Experciences

  describe "experciences" do
    alias Portfolio.Experciences.Expercience

    import Portfolio.ExperciencesFixtures

    @invalid_attrs %{active: nil, current_work: nil, end_date: nil, name: nil, start_date: nil}

    test "list_experciences/0 returns all experciences" do
      expercience = expercience_fixture()
      assert Experciences.list_experciences() == [expercience]
    end

    test "get_expercience!/1 returns the expercience with given id" do
      expercience = expercience_fixture()
      assert Experciences.get_expercience!(expercience.id) == expercience
    end

    test "create_expercience/1 with valid data creates a expercience" do
      valid_attrs = %{active: true, current_work: true, end_date: ~D[2022-04-22], name: "some name", start_date: ~D[2022-04-22]}

      assert {:ok, %Expercience{} = expercience} = Experciences.create_expercience(valid_attrs)
      assert expercience.active == true
      assert expercience.current_work == true
      assert expercience.end_date == ~D[2022-04-22]
      assert expercience.name == "some name"
      assert expercience.start_date == ~D[2022-04-22]
    end

    test "create_expercience/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Experciences.create_expercience(@invalid_attrs)
    end

    test "update_expercience/2 with valid data updates the expercience" do
      expercience = expercience_fixture()
      update_attrs = %{active: false, current_work: false, end_date: ~D[2022-04-23], name: "some updated name", start_date: ~D[2022-04-23]}

      assert {:ok, %Expercience{} = expercience} = Experciences.update_expercience(expercience, update_attrs)
      assert expercience.active == false
      assert expercience.current_work == false
      assert expercience.end_date == ~D[2022-04-23]
      assert expercience.name == "some updated name"
      assert expercience.start_date == ~D[2022-04-23]
    end

    test "update_expercience/2 with invalid data returns error changeset" do
      expercience = expercience_fixture()
      assert {:error, %Ecto.Changeset{}} = Experciences.update_expercience(expercience, @invalid_attrs)
      assert expercience == Experciences.get_expercience!(expercience.id)
    end

    test "delete_expercience/1 deletes the expercience" do
      expercience = expercience_fixture()
      assert {:ok, %Expercience{}} = Experciences.delete_expercience(expercience)
      assert_raise Ecto.NoResultsError, fn -> Experciences.get_expercience!(expercience.id) end
    end

    test "change_expercience/1 returns a expercience changeset" do
      expercience = expercience_fixture()
      assert %Ecto.Changeset{} = Experciences.change_expercience(expercience)
    end
  end
end
