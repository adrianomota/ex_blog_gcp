defmodule ExBlogGcp.Post.Posts do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :description, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(posts, attrs) do
    posts
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
