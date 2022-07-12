defmodule PortfolioWeb.Admin.ExpercienceLive.Form do
  use PortfolioWeb, :live_view

  alias Portfolio.Experciences
  alias Portfolio.Companies
  alias Portfolio.Experciences.Expercience

  on_mount({PortfolioWeb.LiveHelpers, :current_user})

  @impl true
  def mount(params, _session, socket) do
    user = socket.assigns.current_user

    expercience =
      if params["id"], do: Experciences.get_expercience!(params["id"]), else: %Expercience{}

    changeset = Experciences.change_expercience(expercience)

    {:ok,
     socket
     |> assign(:changeset, changeset)
     |> assign(:expercience, expercience)
     |> assign(:is_current_work, expercience.current_work)
     |> assign(:company_opts, company_opts(user, expercience))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, _params) do
    assign(socket, :page_title, "Edit Expercience")
  end

  defp apply_action(socket, :new, _params) do
    assign(socket, :page_title, "New Expercience")
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
    save_expercience(socket, socket.assigns.live_action, expercience_params)
  end

  defp save_expercience(socket, :edit, expercience_params) do
    case Experciences.update_expercience(socket.assigns.expercience, expercience_params) do
      {:ok, expercience} ->
        {:noreply,
         socket
         |> put_flash(:info, "Expercience updated successfully")
         |> push_redirect(
           to: Routes.admin_expercience_show_path(PortfolioWeb.Endpoint, :show, expercience)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_expercience(socket, :new, expercience_params) do
    current_user = socket.assigns.current_user
    expercience_params = Map.put(expercience_params, "user_id", current_user.id)

    case Experciences.create_expercience(expercience_params) do
      {:ok, expercience} ->
        {:noreply,
         socket
         |> put_flash(:info, "Expercience created successfully")
         |> push_redirect(
           to: Routes.admin_expercience_show_path(PortfolioWeb.Endpoint, :show, expercience)
         )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp company_opts(user, expercience) do
    for company <- list_companies(user),
        do: [
          key: company.name,
          value: company.id,
          selected: company.id == expercience.company_id
        ]
  end

  defp list_companies(user) do
    Companies.list_companies_by_user_id(user.id)
  end
end
