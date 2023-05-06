defmodule Servy.Api.User do
  def query(id) when is_integer(id) do
    id = Integer.to_string(id)
    query(id)
  end

  def query(id) do
    HTTPoison.get("https://jsonplaceholder.typicode.com/users/" <> id)
    |> handle_response
  end

  def handle_response({:ok, response}) do
    Poison.Parser.parse!(response.body, %{})
    |> Map.get("address")
    |> Map.get("city")

    # |> (&get_in(&1, ["address", "city"]))
  end

  def handle_response({:error, error}) do
    Poison.Parser.parse!(error)
    |> inspect
  end
end
