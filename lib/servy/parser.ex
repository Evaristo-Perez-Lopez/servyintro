defmodule Servy.Parser do
  def parse(request) do
    [method, path, _] =
      request
      |> String.split("\n")
      |> Enum.at(0)
      |> String.split(" ")

    %{method: method, path: path, status: nil, resp_body: ""}
  end
end
