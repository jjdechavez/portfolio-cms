defmodule PortfolioWeb.Admin.ExpercienceLiveTest do
  use PortfolioWeb.ConnCase

  import Phoenix.LiveViewTest
  import Portfolio.ExperciencesFixtures

  @create_attrs %{
    active: true,
    current_work: true,
    end_date: %{day: 22, month: 4, year: 2022},
    name: "some name",
    start_date: %{day: 22, month: 4, year: 2022}
  }
  @update_attrs %{
    active: false,
    current_work: false,
    end_date: %{day: 23, month: 4, year: 2022},
    name: "some updated name",
    start_date: %{day: 23, month: 4, year: 2022}
  }
  @invalid_attrs %{
    active: false,
    current_work: false,
    end_date: %{day: 30, month: 2, year: 2022},
    name: nil,
    start_date: %{day: 30, month: 2, year: 2022}
  }

  defp create_expercience(_) do
    expercience = expercience_fixture()
    %{expercience: expercience}
  end

  describe "Index" do
    setup [:create_expercience]

    test "lists all experciences", %{conn: conn, expercience: expercience} do
      {:ok, _index_live, html} = live(conn, Routes.admin_expercience_index_path(conn, :index))

      assert html =~ "Listing Experciences"
      assert html =~ expercience.name
    end

    test "saves new expercience", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.admin_expercience_index_path(conn, :index))

      assert index_live |> element("a", "New Expercience") |> render_click() =~
               "New Expercience"

      assert_patch(index_live, Routes.admin_expercience_index_path(conn, :new))

      assert index_live
             |> form("#expercience-form", expercience: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#expercience-form", expercience: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.admin_expercience_index_path(conn, :index))

      assert html =~ "Expercience created successfully"
      assert html =~ "some name"
    end

    test "updates expercience in listing", %{conn: conn, expercience: expercience} do
      {:ok, index_live, _html} = live(conn, Routes.admin_expercience_index_path(conn, :index))

      assert index_live |> element("#expercience-#{expercience.id} a", "Edit") |> render_click() =~
               "Edit Expercience"

      assert_patch(index_live, Routes.admin_expercience_index_path(conn, :edit, expercience))

      assert index_live
             |> form("#expercience-form", expercience: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#expercience-form", expercience: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.admin_expercience_index_path(conn, :index))

      assert html =~ "Expercience updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes expercience in listing", %{conn: conn, expercience: expercience} do
      {:ok, index_live, _html} = live(conn, Routes.admin_expercience_index_path(conn, :index))

      assert index_live |> element("#expercience-#{expercience.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#expercience-#{expercience.id}")
    end
  end

  describe "Show" do
    setup [:create_expercience]

    test "displays expercience", %{conn: conn, expercience: expercience} do
      {:ok, _show_live, html} =
        live(conn, Routes.admin_expercience_show_path(conn, :show, expercience))

      assert html =~ "Show Expercience"
      assert html =~ expercience.name
    end

    test "updates expercience within modal", %{conn: conn, expercience: expercience} do
      {:ok, show_live, _html} =
        live(conn, Routes.admin_expercience_show_path(conn, :show, expercience))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Expercience"

      assert_patch(show_live, Routes.admin_expercience_show_path(conn, :edit, expercience))

      assert show_live
             |> form("#expercience-form", expercience: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#expercience-form", expercience: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.admin_expercience_show_path(conn, :show, expercience))

      assert html =~ "Expercience updated successfully"
      assert html =~ "some updated name"
    end
  end
end
