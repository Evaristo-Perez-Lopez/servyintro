defmodule Servy.Handler do
  def handle(request) do
    # conv = parse(request)
    # conv = route(conv)
    # conv = format_response(conv)

    request
    |> parse
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
    %{method: "GET", path: "/wildthings", resp_body: ""}
  end

  def route(conv) do
    # IO.puts("ROUTE: #{conv}")
    _conv = %{method: "GET", path: "/wildthings", resp_body: "Hello from Servy!"}
  end

  def format_response(conv) do
    # IO.puts("FORMAT: #{conv}")

    """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 20
    
    Hello from Servy!
    """
  end
end

request = """
GET /wildthings HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)
IO.puts(response)
