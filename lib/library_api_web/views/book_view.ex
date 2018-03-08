defmodule LibraryApiWeb.BookView do
  use LibraryApiWeb, :view
  use JaSerializer.PhoenixView

  location "/books/:id"
  attributes [:title, :isbn, :publish_date]


end
