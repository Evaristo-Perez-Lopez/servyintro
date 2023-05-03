defmodule Servy.Conv do
  defstruct method: "", path: "", resp_body: "", status: nil

  def full_status(conv) do
    "# {conv.status} #{message_reason(conv.status)}"
  end

  defp message_reason(code) do
    %{
      200 => "OK",
      201 => "Created",
      400 => "Bad Request",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error"
    }[code]
  end
end