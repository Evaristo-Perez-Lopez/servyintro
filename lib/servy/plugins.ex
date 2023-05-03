defmodule Servy.Plugins do
  alias Servy.Conv

  def track_errors(%Conv{status: 404, path: path} = conv) do
    IO.puts("Error 404 in #{path}")
    conv
  end

  def track_errors(%Conv{} = conv), do: conv
  def log(conv), do: IO.inspect(conv)
end
