defmodule Servy.Timer do
  def timer(conv, time) when is_bitstring(time) do
    IO.puts("Formatting")
    timer(conv, String.to_integer(time))
  end

  def timer(conv, 5000 = time) do
    :timer.sleep(time)
    mesg = 'Aver 5000'
    IO.puts(mesg)
    conv
  end

  def timer(conv, 1000 = time) do
    :timer.sleep(time)
    mesg = 'Aver 1000'
    IO.puts(mesg)
    conv
  end

  def timer(conv, 15000 = time) do
    :timer.sleep(time)
    mesg = 'Aver 15000'
    IO.puts(mesg)
    conv
  end
end
