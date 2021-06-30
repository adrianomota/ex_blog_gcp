defmodule ExBlogGcpWeb.PostsControllerTest do
  use ExBlogGcpWeb.ConnCase

  alias ExBlogGcp.Post

  @create_attrs %{description: "some description", title: "some title"}
  @update_attrs %{description: "some updated description", title: "some updated title"}
  @invalid_attrs %{description: nil, title: nil}

  def fixture(:posts) do
    {:ok, posts} = Post.create_posts(@create_attrs)
    posts
  end

  describe "index" do
    test "lists all posts", %{conn: conn} do
      conn = get(conn, Routes.posts_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Posts"
    end
  end

  describe "new posts" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.posts_path(conn, :new))
      assert html_response(conn, 200) =~ "New Posts"
    end
  end

  describe "create posts" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.posts_path(conn, :create), posts: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.posts_path(conn, :show, id)

      conn = get(conn, Routes.posts_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Posts"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.posts_path(conn, :create), posts: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Posts"
    end
  end

  describe "edit posts" do
    setup [:create_posts]

    test "renders form for editing chosen posts", %{conn: conn, posts: posts} do
      conn = get(conn, Routes.posts_path(conn, :edit, posts))
      assert html_response(conn, 200) =~ "Edit Posts"
    end
  end

  describe "update posts" do
    setup [:create_posts]

    test "redirects when data is valid", %{conn: conn, posts: posts} do
      conn = put(conn, Routes.posts_path(conn, :update, posts), posts: @update_attrs)
      assert redirected_to(conn) == Routes.posts_path(conn, :show, posts)

      conn = get(conn, Routes.posts_path(conn, :show, posts))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, posts: posts} do
      conn = put(conn, Routes.posts_path(conn, :update, posts), posts: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Posts"
    end
  end

  describe "delete posts" do
    setup [:create_posts]

    test "deletes chosen posts", %{conn: conn, posts: posts} do
      conn = delete(conn, Routes.posts_path(conn, :delete, posts))
      assert redirected_to(conn) == Routes.posts_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.posts_path(conn, :show, posts))
      end
    end
  end

  defp create_posts(_) do
    posts = fixture(:posts)
    %{posts: posts}
  end
end
