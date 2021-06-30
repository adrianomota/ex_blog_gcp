defmodule ExBlogGcpWeb.PostsController do
  use ExBlogGcpWeb, :controller

  alias ExBlogGcp.Post
  alias ExBlogGcp.Post.Posts

  def index(conn, _params) do
    posts = Post.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Post.change_posts(%Posts{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"posts" => posts_params}) do
    case Post.create_posts(posts_params) do
      {:ok, posts} ->
        conn
        |> put_flash(:info, "Posts created successfully.")
        |> redirect(to: Routes.posts_path(conn, :show, posts))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    posts = Post.get_posts!(id)
    render(conn, "show.html", posts: posts)
  end

  def edit(conn, %{"id" => id}) do
    posts = Post.get_posts!(id)
    changeset = Post.change_posts(posts)
    render(conn, "edit.html", posts: posts, changeset: changeset)
  end

  def update(conn, %{"id" => id, "posts" => posts_params}) do
    posts = Post.get_posts!(id)

    case Post.update_posts(posts, posts_params) do
      {:ok, posts} ->
        conn
        |> put_flash(:info, "Posts updated successfully.")
        |> redirect(to: Routes.posts_path(conn, :show, posts))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", posts: posts, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    posts = Post.get_posts!(id)
    {:ok, _posts} = Post.delete_posts(posts)

    conn
    |> put_flash(:info, "Posts deleted successfully.")
    |> redirect(to: Routes.posts_path(conn, :index))
  end
end
