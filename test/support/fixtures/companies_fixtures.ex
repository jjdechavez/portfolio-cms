defmodule Portfolio.CompaniesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Portfolio.Companies` context.
  """

  @doc """
  Generate a company.
  """
  def company_fixture(attrs \\ %{}) do
    {:ok, company} =
      attrs
      |> Enum.into(%{
        location: "some location",
        name: "some name",
        url_link: "some url_link"
      })
      |> Portfolio.Companies.create_company()

    company
  end
end
