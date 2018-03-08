defmodule LibraryApiWeb.BookController do
  use LibraryApiWeb, :controller
  alias LibraryApi.Library
  alias LibraryApi.Library.Book

  def index(conn, %{"filter" => %{"query" => search_term}}) do
    books = Library.search_books(search_term)

    render(conn, "index.json-api", data: books)
  end

  def index(conn, _params) do
    books = Library.list_books

    render(conn, "index.json-api", data: books)
  end

  def show(conn, %{"id" => id}) do
    book = Library.get_book!(id)

    render(conn, "show.json-api", data: book)
  end

  def create(conn, %{"data" => data = %{"type" => "books", "attributes" => _book_params }}) do
    data = JaSerializer.Params.to_attributes data
    data = Map.put data, "publish_date", Date.from_iso8601!(data["publish_date"])

    with {:ok, %Book{} = book} <- Library.create_book(data) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", book_path(conn, :show, book))
      |> render("show.json-api", data: book)
    end
  end

  def update(conn, %{"id" => id, "data" => data = %{"type" => "books", "attributes" => _book_params }}) do
    book = Library.get_book!(id)
    data = JaSerializer.Params.to_attributes data

    if data["publish_date"] do
      data = Map.put data, "publish_date", Date.from_iso8601!(data["publish_date"])
    end

    with {:ok, %Book{} = book} <- Library.update_book(book, data) do
      conn
      |> render("show.json-api", data: book)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Library.get_book!(id)

    with {:ok, %Book{}} <- Library.delete_book(book) do
      send_resp(conn, :no_content, "")
    end
  end
end
