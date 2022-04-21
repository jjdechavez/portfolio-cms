# Portfolio

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix

## Features

- Project module
- Company module
- Expercience module
- Tools module: tools that used on development. (Check the newset version and update the local tools by creating bash script/elixir)
  - name: string
  - status: boolean
  - link_url: string
  - version: string
  - user_id: references users
- Resources module: Web tips
  - name: string
  - status: boolean
  - link_url: string
  - tags: string[]
  - user_id: references users
- Tag module
  - name: string
  - status: boolean
  - user_id: references users
