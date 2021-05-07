defmodule MurderSheWroteWeb.PageControllerTest do
  use MurderSheWroteWeb.ConnCase

  test "Visiting the homepage returns a 200 Status Code and contains right contents", %{
    conn: conn
  } do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "<h1>Murder She Wrote</h1>"
  end
end
