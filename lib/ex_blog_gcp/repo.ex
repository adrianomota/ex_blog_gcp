defmodule ExBlogGcp.Repo do
  use Ecto.Repo,
    otp_app: :ex_blog_gcp,
    adapter: Ecto.Adapters.Postgres
end
