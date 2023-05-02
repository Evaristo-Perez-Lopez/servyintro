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
    %{method: method, path: path, resp_body: ""}
  end

  def route(conv) do
    # conv = %{method: "GET", path: "/wildthings", resp_body: "Hello from Servy!"}
    %{conv | resp_body: "Hello from Servy!"}
  end

  def format_response(conv) do
    # IO.puts("FORMAT: #{conv}")
    IO.puts("--- FORMAT ---")

    """
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: #{byte_size(conv.resp_body)}
    
    #{conv.resp_body}
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
