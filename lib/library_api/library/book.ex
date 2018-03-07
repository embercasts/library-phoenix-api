defmodule LibraryApi.Library.Book do
  use Ecto.Schema
  import Ecto.Changeset
  alias LibraryApi.Library.Author
  alias LibraryApi.Library.Book

  schema "books" do
    field :title, :string
    field :isbn, :string
    field :publish_date, :date

    belongs_to :author, Author

    timestamps()
  end

  @required_fields [:title, :isbn, :publish_date, :author_id]

  def changeset(%Book{} = model, attrs) do
    model
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
