defmodule Servy.Handler do
  def handle(request) do
    # conv = parse(request)
    # conv = route(conv)
    # conv = format_response(conv)

    request
    |> parse
    |> log
    |> route
    |> track_errors
    |> format_response
  end

  def track_errors(%{status: 404, path: path} = conv) do
    IO.puts("Error 404 in #{path}")
    conv
  end

  def track_errors(conv), do: conv

  def parse(request) do
    # Desestructura el arreglo (tupla)
    [method, path, _] =
      request
      |> String.split("\n")
      |> Enum.at(0)
      |> String.split(" ")

    IO.puts("METHOD: #{method}")
    IO.puts("PATH: #{path}")
    %{method: method, path: path, status: nil, resp_body: ""}
  end

  # single_line function
  def log(conv), do: IO.inspect(conv)

  # def route(conv) do
  #   route(conv, conv.method, conv.path)
  # end

  # functions clauses
  def route(%{method: "GET", path: "/gender"} = conv) do
    %{conv | status: 200, resp_body: "Rock, Blue, Classic"}
  end

  def route(%{method: "GET", path: "/author"} = conv) do
    %{conv | status: 200, resp_body: "Eva, Logi, Beto"}
  end

  def route(%{method: "GET", path: "/author/" <> id} = conv) do
    %{conv | status: 200, resp_body: "Eva #{String.upcase(id)}"}
  end

  # define a function to match any other path or method
  def route(%{path: path} = conv) do
    %{conv | status: 404, resp_body: "Not found #{path}"}
  end

  def format_response(conv) do
    """
    HTTP/1.1 #{conv.status} #{message_reason(conv.status)}
    Content-Type: text/html
    Content-Length: #{byte_size(conv.resp_body)}
    
    #{conv.resp_body}
    """
  end

  defp message_reason(code) do
    %{
      200 => "OK",
      201 => "Created",
      400 => "Bad Request",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error"
    }[code]
  end
end

request = """
GET /gender HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)
IO.puts(response)

request = """
GET /author HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)
IO.puts(response)

request = """
GET /noncatch HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)
IO.puts(response)

request = """
GET /author/eva HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)
IO.puts(response)
