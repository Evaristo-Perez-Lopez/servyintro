defmodule Servy.ReadCsv do
  @path Path.expand("../../pages/", __DIR__)
  def read do
    Path.join(@path, "test.csv")
    |> File.read()
    # |> String.split("\r\n")
    |> print
  end

  def print(file) do
    IO.puts(file)
  end
end
