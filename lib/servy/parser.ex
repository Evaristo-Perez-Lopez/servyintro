defmodule Servy.Parser do
  alias Servy.Conv

  def parse(request) do
    [top, params_string] = String.split(request, "\n\r\n")
    [req_line | header_lines] = String.split(top, "\n")

    [method, path, _] = String.split(req_line, " ")
    headers = parse_headers(header_lines, %{})
    params = parse_params(headers["Content-Type"], params_string)
    IO.inspect(header_lines)

    # [method, path, _] =
    #   top
    #   |> String.split("\n")
    #   |> Enum.at(0)
    #   |> String.split(" ")

    %Conv{method: method, path: path, headers: headers, params: params}
  end

  def parse_params("application/x-www-form-urlencoded\r", params_string) do
    params_string |> String.trim() |> URI.decode_query()
  end

  def parse_params(_, _), do: %{}

  def parse_headers([head | tail], headers) do
    [key, value] = String.split(head, ": ")
    headers = Map.put(headers, key, value)
    parse_headers(tail, headers)
  end

  def parse_headers([], headers), do: headers
end
