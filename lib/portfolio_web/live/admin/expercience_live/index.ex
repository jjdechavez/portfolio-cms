defmodule PortfolioWeb.Admin.ExpercienceLive.Index do
  use PortfolioWeb, :live_view

  alias Portfolio.Experciences

  on_mount({PortfolioWeb.LiveHelpers, :current_user})

  @impl true
  def mount(_params, _session, socket) do
    user = socket.assigns.current_user
    {:ok, assign(socket, :experciences, list_experciences(user))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :delete, %{"id" => id}) do
    socket
    |> assign(:page_title, "Delete Expercience")
    |> assign(:expercience_id, id)
    |> assign(:expercience, Experciences.get_expercience!(id))
    |> assign(:return_to, Routes.admin_expercience_index_path(socket, :index))
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Experciences")
    |> assign(:expercience, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => expercience_id}, socket) do
    user = socket.assigns.current_user
    id = String.to_integer(expercience_id)

    expercience = Experciences.get_expercience!(id)
    {:ok, _} = Experciences.delete_expercience(expercience)

    {:noreply,
     socket
     |> assign(:experciences, list_experciences(user))
     |> put_flash(:info, "Expercience deleted successfully!")
     |> push_patch(to: socket.assigns.return_to)}
  end

  defp list_experciences(user) do
    Experciences.list_experciences_by_user_id(user.id)
  end
end
