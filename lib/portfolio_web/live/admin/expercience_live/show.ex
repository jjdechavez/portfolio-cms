defmodule PortfolioWeb.Admin.ExpercienceLive.Show do
  use PortfolioWeb, :live_view

  alias Portfolio.Experciences

  on_mount({PortfolioWeb.LiveHelpers, :current_user})

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:expercience, Experciences.get_expercience!(id))}
  end

  defp page_title(:show), do: "Show Expercience"
  defp page_title(:edit), do: "Edit Expercience"
end
