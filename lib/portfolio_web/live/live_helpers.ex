defmodule PortfolioWeb.LiveHelpers do
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers

  alias Phoenix.LiveView.JS

  alias Portfolio.Accounts

  def on_mount(:current_user, _params, session, socket) do
    socket =
      assign_new(socket, :current_user, fn ->
        Accounts.get_user_by_session_token(session["user_token"])
      end)

    if socket.assigns.current_user do
      {:cont, socket}
    else
      {:halt, redirect(socket, to: "/admin")}
    end
  end

  @doc """
  Renders a live component inside a modal.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <.modal return_to={Routes.company_index_path(@socket, :index)}>
        <.live_component
          module={PortfolioWeb.Admin.CompanyLive.FormComponent}
          id={@company.id || :new}
          title={@page_title}
          action={@live_action}
          return_to={Routes.company_index_path(@socket, :index)}
          company: @company
        />
      </.modal>
  """

  def modal(assigns) do
    assigns =
      assigns
      |> assign_new(:return_to, fn -> nil end)
      |> assign_new(:confirm, fn -> [] end)
      |> assign_new(:cancel, fn -> [] end)

    ~H"""
    <dialog 
      id="modal" 
      class="phx-modal fade-in" 
      phx-remove={hide_modal()} 
      open={if @title, do: 'true'}
    >
      <article
        id="modal-content"
        class="fade-in-scale"
        phx-click-away={JS.dispatch("click", to: "#close")}
        phx-window-keydown={JS.dispatch("click", to: "#close")}
        phx-key="escape"
        style="width: 30vw;"
      >
         <%= live_patch "",
           to: @return_to,
           id: "close",
           class: "close modal-close",
           phx_click: hide_modal()
         %>
        <h3><%= @title %></h3>

        <%= render_slot(@inner_block) %>

        <%= if length(@cancel) > 0 or length(@confirm) > 0 do %>
         <footer>
          <%= for cancel <- @cancel do %>
           <%= live_patch cancel.title, to: @return_to, role: "button", class: "secondary modal-close" %>
          <% end %>
          <%= for confirm <- @confirm do %>
           <a id="modal-confirm" href="#" role="button" phx-click={confirm_event_modal(confirm.event)} phx-value-id={"#{confirm.value}"} phx-disable-with={"#{confirm.disable_title}"}>
             <%= render_slot(@confirm) %>
           </a>
          <% end %>
         </footer>
        <% end %>
      </article>
    </dialog>
    """
  end

  defp hide_modal(js \\ %JS{}) do
    js
    |> JS.hide(to: "#modal", transition: "fade-out")
    |> JS.hide(to: "#modal-content", transition: "fade-out-scale")
  end

  defp confirm_event_modal(js \\ %JS{}, event) do
    js
    |> JS.push(event, loading: ".modal-close")
    |> JS.set_attribute({"aria-busy", "true"}, to: "#modal-confirm")
    |> JS.remove_attribute("phx-click-away", to: "#modal-content")
    |> JS.remove_attribute("phx-window-keydown", to: "#modal-content")
  end
end
