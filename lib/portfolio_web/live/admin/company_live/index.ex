defmodule PortfolioWeb.Admin.CompanyLive.Index do
  use PortfolioWeb, :live_view

  alias Portfolio.Companies
  alias Portfolio.Companies.Company

  on_mount({PortfolioWeb.LiveHelpers, :current_user})

  @impl true
  def mount(_params, _session, socket) do
    user = socket.assigns.current_user

    socket =
      socket
      |> assign(:companies, list_companies(user))

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

  defp apply_action(socket, :delete, %{"id" => id}) do
    socket
    |> assign(:page_title, "Delete Company")
    |> assign(:company, Companies.get_company!(id))
    |> assign(:return_to, Routes.admin_company_index_path(socket, :index))
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Companies")
    |> assign(:company, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user = socket.assigns.current_user
    company = Companies.get_company!(id)
    {:ok, _} = Companies.delete_company(company)

    {:noreply,
     socket
     |> assign(:companies, list_companies(user))
     |> put_flash(:info, "Company deleted successfully!")
     |> push_redirect(to: socket.assigns.return_to)}
  end

  defp list_companies(user) do
    Companies.list_companies_by_user_id(user.id)
  end
end
