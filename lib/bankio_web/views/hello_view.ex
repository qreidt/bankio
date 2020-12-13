defmodule AppWeb.HelloView do
  use AppWeb, :view

  def render("hello.json", %{key: key}) do
    %{hello: key}
  end
end
