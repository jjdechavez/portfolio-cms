defmodule Portfolio.Experciences do
  @moduledoc """
  The Experciences context.
  """

  import Ecto.Query, warn: false
  alias Portfolio.Repo

  alias Portfolio.Experciences.Expercience

  @doc """
  Returns the list of experciences.

  ## Examples

      iex> list_experciences()
      [%Expercience{}, ...]

  """
  def list_experciences do
    Repo.all(Expercience)
  end

  @doc """
  Gets a single expercience.

  Raises `Ecto.NoResultsError` if the Expercience does not exist.

  ## Examples

      iex> get_expercience!(123)
      %Expercience{}

      iex> get_expercience!(456)
      ** (Ecto.NoResultsError)

  """
  def get_expercience!(id), do: Repo.get!(Expercience, id)

  @doc """
  Creates a expercience.

  ## Examples

      iex> create_expercience(%{field: value})
      {:ok, %Expercience{}}

      iex> create_expercience(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_expercience(attrs \\ %{}) do
    %Expercience{}
    |> Expercience.create_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a expercience.

  ## Examples

      iex> update_expercience(expercience, %{field: new_value})
      {:ok, %Expercience{}}

      iex> update_expercience(expercience, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_expercience(%Expercience{} = expercience, attrs) do
    expercience
    |> Expercience.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a expercience.

  ## Examples

      iex> delete_expercience(expercience)
      {:ok, %Expercience{}}

      iex> delete_expercience(expercience)
      {:error, %Ecto.Changeset{}}

  """
  def delete_expercience(%Expercience{} = expercience) do
    Repo.delete(expercience)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking expercience changes.

  ## Examples

      iex> change_expercience(expercience)
      %Ecto.Changeset{data: %Expercience{}}

  """
  def change_expercience(%Expercience{} = expercience, attrs \\ %{}) do
    Expercience.changeset(expercience, attrs)
  end
end
