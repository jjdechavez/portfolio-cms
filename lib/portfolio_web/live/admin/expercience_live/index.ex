defmodule PortfolioWeb.Admin.ExpercienceLive.Index do
  use PortfolioWeb, :live_view

  alias Portfolio.Experciences
  alias Portfolio.Experciences.Expercience

  on_mount({PortfolioWeb.LiveHelpers, :current_user})

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :experciences, list_experciences())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Expercience")
    |> assign(:expercience, Experciences.get_expercience!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Expercience")
    |> assign(:expercience, %Expercience{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Experciences")
    |> assign(:expercience, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    expercience = Experciences.get_expercience!(id)
    {:ok, _} = Experciences.delete_expercience(expercience)

    {:noreply, assign(socket, :experciences, list_experciences())}
  end

  defp list_experciences do
    Experciences.list_experciences()
  end
end
