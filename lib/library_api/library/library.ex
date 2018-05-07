defmodule LibraryApi.Library do
  @moduledoc """
  The Library context.
  """

  import Ecto.Query, warn: false
  alias LibraryApi.Repo

  alias LibraryApi.Library.Author
  alias LibraryApi.Library.Book
  alias LibraryApi.Library.Review

  def list_authors, do: Repo.all(Author)

  def search_authors(search_term) do
    search_term = String.downcase(search_term)

    Author
    |> where([a], like(fragment("lower(?)", a.first), ^"%#{search_term}%"))
    |> or_where([a], like(fragment("lower(?)", a.last), ^"%#{search_term}%"))
    |> Repo.all()
  end

  def get_author!(id), do: Repo.get!(Author, id)

  def get_author_for_book!(book_id) do
    book = get_book!(book_id)

    book = Repo.preload(book, :author)

    book.author
  end

  def create_author(attrs \\ %{}) do
    %Author{}
    |> Author.changeset(attrs)
    |> Repo.insert
  end

  def update_author(%Author{} = model, attrs \\ %{}) do
    model
    |> Author.changeset(attrs)
    |> Repo.update
  end

  def delete_author(%Author{} = model), do: Repo.delete(model)

  # Books
  def list_books, do: Repo.all(Book)

  def list_books_for_author(author_id) do
    Book
    |> where([b], b.author_id == ^author_id)
    |> Repo.all()
  end

  def search_books(search_term) do
    search_term = String.downcase(search_term)

    Book
    |> where([b], like(fragment("lower(?)", b.title), ^"%#{search_term}%"))
    |> or_where([b], like(fragment("lower(?)", b.isbn), ^"%#{search_term}%"))
    |> Repo.all()
  end

  def get_book!(id), do: Repo.get!(Book, id)

  def get_book_for_review!(review_id) do
    review = get_review!(review_id)

    review = Repo.preload(review, :book)

    review.book
  end

  def create_book(attrs \\ %{}) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert
  end

  def update_book(%Book{} = model, attrs \\ %{}) do
    model
    |> Book.changeset(attrs)
    |> Repo.update
  end

  def delete_book(%Book{} = model), do: Repo.delete(model)

  @doc """
  Returns the list of reviews.

  ## Examples

      iex> list_reviews()
      [%Review{}, ...]

  """
  def list_reviews do
    Repo.all(Review)
  end

  def list_reviews_for_book(book_id) do
    Review
    |> where([r], r.book_id == ^book_id)
    |> Repo.all()
  end

  @doc """
  Gets a single review.

  Raises `Ecto.NoResultsError` if the Review does not exist.

  ## Examples

      iex> get_review!(123)
      %Review{}

      iex> get_review!(456)
      ** (Ecto.NoResultsError)

  """
  def get_review!(id), do: Repo.get!(Review, id)

  @doc """
  Creates a review.

  ## Examples

      iex> create_review(%{field: value})
      {:ok, %Review{}}

      iex> create_review(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_review(attrs \\ %{}) do
    %Review{}
    |> Review.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a review.

  ## Examples

      iex> update_review(review, %{field: new_value})
      {:ok, %Review{}}

      iex> update_review(review, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_review(%Review{} = review, attrs) do
    review
    |> Review.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Review.

  ## Examples

      iex> delete_review(review)
      {:ok, %Review{}}

      iex> delete_review(review)
      {:error, %Ecto.Changeset{}}

  """
  def delete_review(%Review{} = review) do
    Repo.delete(review)
  end

  alias LibraryApi.Library.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end
