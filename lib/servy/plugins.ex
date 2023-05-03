defmodule Servy.Plugins do
  def track_errors(%{status: 404, path: path} = conv) do
    IO.puts("Error 404 in #{path}")
    conv
  end

  def track_errors(conv), do: conv
  def log(conv), do: IO.inspect(conv)
end
