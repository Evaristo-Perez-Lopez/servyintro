defmodule Source.BearController do
  alias Source.Wildthings
  alias Source.Bear
  @templates_path Path.expand("../../templates", __DIR__)

  defp bear_item(bear) do
    "<li>#{bear.name} - #{bear.type}</li>"
  end

  defp render(conv, template, bindings) do
    content =
      @templates_path
      |> Path.join(template)
      |> EEx.eval_file(bindings)

    %{conv | status: 200, resp_body: content}
  end

  def index(conv) do
    # items =
    #   Wildthings.list_bears()
    #   |> Enum.filter(&Bear.is_grizzly/1)
    #   |> Enum.sort(&Bear.order_asc_by_name/2)
    #   |> Enum.map(&bear_item/1)
    #   |> Enum.join()
    bears =
      Wildthings.list_bears()
      |> Enum.sort(&Bear.order_asc_by_name/2)

    render(conv, "index.eex", bears: bears)
  end

  def show(conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)
    render(conv, "show.eex", bear: bear)
  end

  def create(conv, %{"name" => name, "type" => type}) do
    %{conv | status: 201, resp_body: "Created a #{type} bear named #{name}!"}
  end
end
