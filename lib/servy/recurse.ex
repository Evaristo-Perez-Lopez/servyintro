defmodule Servy.Recurse do
  def loopy([head | tail]) do
    IO.puts("Head: #{head} Tail: #{inspect(tail)}")
    loopy(tail)
  end

  def loopy([]), do: IO.puts("Done!")

  def triple(list) do
    triple(list, [])
  end

  def triple([left | right], acum) do
    acum = [left * 3 | acum]
    IO.inspect(acum)
    triple(right, acum)
  end

  def triple([], acum) do
    ep = Enum.reverse(acum)
    IO.inspect(ep)
  end
end

Servy.Recurse.loopy([1, 2, 3, 4, 5])
Servy.Recurse.triple([1, 2, 3, 4, 5])
