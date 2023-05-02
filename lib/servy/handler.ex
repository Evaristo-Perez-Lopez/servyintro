defmodule Servy.Handler do
  def handle(request) do
    # conv = parse(request)
    # conv = route(conv)
    # conv = format_response(conv)

    request
    |> parse
    |> log
    |> route
    |> format_response
  end

  def parse(request) do
    # Desestructura el arreglo (tupla)
    [method, path, _] =
      request
      |> String.split("\n")
      |> Enum.at(0)
      |> String.split(" ")

    IO.puts("METHOD: #{method}")
    IO.puts("PATH: #{path}")
    %{method: method, path: path, resp_body: ""}
  end

  # single_line function
  def log(conv), do: IO.inspect(conv)

  def route(conv) do
    route(conv, conv.method, conv.path)
  end

  # functions clauses
  def route(conv, "GET", "/gender") do
    %{conv | resp_body: "Rock, Blue, Classic"}
  end

  def route(conv, "GET", "/author") do
    %{conv | resp_body: "Eva, Logi, Beto"}
  end

  def format_response(conv) do
    """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: #{byte_size(conv.resp_body)}
    
    #{conv.resp_body}
    """
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
