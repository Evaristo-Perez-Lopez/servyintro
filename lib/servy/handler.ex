defmodule Servy.Handler do
  @moduledoc """
  Handles HTTP resquest
  """

  @pages_path Path.expand("../../pages/", __DIR__)
  alias Servy.Conv
  import Servy.Plugins, only: [log: 1, track_errors: 1]
  import Servy.Parser, only: [parse: 1]

  @doc """
  handle the request
  """
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

  @doc """
  Desestructura el arreglo (tupla)
  """

  # single_line function
  # functions clauses

  def route(%Conv{method: "GET", path: "/gender"} = conv) do
    %{conv | status: 200, resp_body: "Rock, Blue, Classic"}
  end

  def route(%Conv{method: "POST", path: "/author", params: params} = conv) do
    %{"name" => name} = params
    # IO.puts(name)
    %{conv | status: 200, resp_body: "Created author #{name}"}
  end

  def route(%Conv{method: "GET", path: "/author"} = conv) do
    %{conv | status: 200, resp_body: "Eva, Logi, Beto"}
  end

  def route(%Conv{method: "GET", path: "/about"} = conv) do
    path = Path.expand("../../pages/", __DIR__) |> Path.join("about.html")
    IO.puts("PATH: #{path}")

    @pages_path
    |> Path.join("about.html")
    |> File.read()
    |> handle_file(conv)

    # notes: refactor to handle this request with function clauses
    # case File.read(path) do
    #   {:ok, content} ->
    #     %{conv | status: 200, resp_body: content}

    #   {:error, :enoent} ->
    #     %{conv | status: 400, resp_body: "Not found"}

    #   {:error, reason} ->
    #     %{conv | status: 500, resp_body: "File error: #{reason}"}
    # end
  end

  def route(%Conv{method: "GET", path: "/author/" <> id} = conv) do
    %{conv | status: 200, resp_body: "Eva #{String.upcase(id)}"}
  end

  # define a function to match any other path or method
  def route(%Conv{path: path} = conv) do
    %{conv | status: 404, resp_body: "Not found #{path}"}
  end

  def handle_file({:ok, content}, conv) do
    %{conv | status: 200, resp_body: content}
  end

  def handle_file({:error, :enoent}, conv) do
    %{conv | status: 400, resp_body: "Not found"}
  end

  def handle_file({:error, reason}, conv) do
    %{conv | status: 500, resp_body: "File error: #{reason}"}
  end

  def format_response(%Conv{} = conv) do
    """
    HTTP/1.1 #{Conv.full_status(conv)}
    Content-Type: text/html
    Content-Length: #{byte_size(conv.resp_body)}
    
    #{conv.resp_body}
    """
  end
end

# request = """
# GET /gender HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# response = Servy.Handler.handle(request)
# IO.puts(response)

# request = """
# GET /author HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# response = Servy.Handler.handle(request)
# IO.puts(response)

# request = """
# GET /noncatch HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# response = Servy.Handler.handle(request)
# IO.puts(response)

# request = """
# GET /author/eva HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# response = Servy.Handler.handle(request)
# IO.puts(response)

# response = Servy.Handler.handle(request)
# IO.puts(response)

# request = """
# GET /about HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

# response = Servy.Handler.handle(request)
# IO.puts(response)

request = """
POST /author HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*
Content-Type: application/x-www-form-urlencoded
Content-Length: 21

name=Baloo&type=Brown
"""

response = Servy.Handler.handle(request)
IO.puts(response)
