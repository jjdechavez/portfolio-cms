defmodule PortfolioWeb.Admin.ExpercienceLive.FormComponent do
  use PortfolioWeb, :live_component

  alias Portfolio.Experciences

  @impl true
  def update(%{expercience: expercience} = assigns, socket) do
    changeset = Experciences.change_expercience(expercience)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:is_current_work, expercience.current_work)}
  end

  @impl true
  def handle_event("validate", %{"expercience" => expercience_params}, socket) do
    changeset =
      socket.assigns.expercience
      |> Experciences.change_expercience(expercience_params)
      |> Map.put(:action, :validate)

    is_current_work = if expercience_params["current_work"] === "true", do: true, else: false

    {:noreply,
     assign(socket,
       changeset: changeset,
       is_current_work: is_current_work
     )}
  end

  def handle_event("save", %{"expercience" => expercience_params}, socket) do
    save_expercience(socket, socket.assigns.action, expercience_params)
  end

  defp save_expercience(socket, :edit, expercience_params) do
    case Experciences.update_expercience(socket.assigns.expercience, expercience_params) do
      {:ok, _expercience} ->
        {:noreply,
         socket
         |> put_flash(:info, "Expercience updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_expercience(socket, :new, expercience_params) do
    case Experciences.create_expercience(expercience_params) do
      {:ok, _expercience} ->
        {:noreply,
         socket
         |> put_flash(:info, "Expercience created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
