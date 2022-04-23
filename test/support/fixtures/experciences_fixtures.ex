defmodule Portfolio.ExperciencesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Portfolio.Experciences` context.
  """

  @doc """
  Generate a expercience.
  """
  def expercience_fixture(attrs \\ %{}) do
    {:ok, expercience} =
      attrs
      |> Enum.into(%{
        active: true,
        current_work: true,
        end_date: ~D[2022-04-22],
        name: "some name",
        start_date: ~D[2022-04-22]
      })
      |> Portfolio.Experciences.create_expercience()

    expercience
  end
end
