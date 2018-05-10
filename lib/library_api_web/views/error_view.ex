defmodule LibraryApiWeb.ErrorView do
  use LibraryApiWeb, :view

  def render("400.json-api", %Ecto.Changeset{} = changeset) do
    JaSerializer.EctoErrorSerializer.format(changeset)
  end

  def render("401.json-api", %{detail: detail}) do
    %{status: 401, title: "Unauthorized", detail: detail}
    |> JaSerializer.ErrorSerializer.format()
  end

  def render("404.json-api", _assigns) do
    %{title: "Page Not Found", status: 404}
    |> JaSerializer.ErrorSerializer.format()
  end

  def render("500.json-api", assigns) do
    IO.inspect assigns


    %{title: "Internal server error", status: 500}
    |> JaSerializer.ErrorSerializer.format()
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.json-api", assigns
  end
end
