defmodule LibraryApiWeb.UserController do
  use LibraryApiWeb, :controller
  alias LibraryApi.Library
  alias LibraryApi.Library.User

  def create(conn, %{"data" => data = %{"type" => "users", "attributes" => _user_attrs}}) do
    attrs = JaSerializer.Params.to_attributes(data)

    with {:ok, %User{} = user} <- Library.create_user(attrs) do
      conn
      |> put_status(:created)
      |> render("show.json-api", data: user)
    end
  end
end
