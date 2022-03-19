defmodule PortfolioWeb.Admin.RegisterLive do
  use PortfolioWeb, :live_view

  alias Portfolio.Accounts
  alias Portfolio.Accounts.User

  def mount(_params, _session, socket) do
    changeset = Accounts.change_user_registration(%User{})

    socket =
      assign(socket,
        changeset: changeset,
        trigger_submit: false
      )

    {:ok, socket}
  end

  def handle_event("save", %{"user" => params}, socket) do
    changeset = registration_changeset(params)

    socket =
      assign(
        socket,
        changeset: changeset,
        trigger_submit: changeset.valid?
      )

    {:noreply, socket}
  end

  def handle_event("validate", %{"user" => params}, socket) do
    changeset = registration_changeset(params)

    socket =
      assign(
        socket,
        changeset: changeset
      )

    {:noreply, socket}
  end

  defp registration_changeset(params) do
    %User{}
    |> Accounts.change_user_registration(params)
    |> Map.put(:action, :insert)
  end
end
