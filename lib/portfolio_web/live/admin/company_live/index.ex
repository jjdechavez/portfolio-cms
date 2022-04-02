defmodule PortfolioWeb.Admin.CompanyLive.Index do
  use PortfolioWeb, :live_view

  alias Portfolio.Companies
  alias Portfolio.Companies.Company

  import PortfolioWeb.LiveHelpers

  @impl true
  def mount(_params, session, socket) do
    socket =
      socket
      |> assign(:companies, list_companies())
      |> assign_current_user(session)

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Company")
    |> assign(:company, Companies.get_company!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Company")
    |> assign(:company, %Company{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Companies")
    |> assign(:company, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    company = Companies.get_company!(id)
    {:ok, _} = Companies.delete_company(company)

    {:noreply, assign(socket, :companies, list_companies())}
  end

  defp list_companies do
    Companies.list_companies()
  end
end
