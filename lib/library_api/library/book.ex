defmodule LibraryApi.Library.Book do
  use Ecto.Schema
  import Ecto.Changeset
  alias LibraryApi.Library.Author
  alias LibraryApi.Library.Book
  alias LibraryApi.Library.Review
  alias LibraryApi.Library.User

  schema "books" do
    field :title, :string
    field :isbn, :string
    field :publish_date, :date

    belongs_to :author, Author
    belongs_to :user, User
    has_many :reviews, Review

    timestamps()
  end

  @required_fields [:title, :isbn, :publish_date, :author_id, :user_id]

  def changeset(%Book{} = model, attrs) do
    model
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
