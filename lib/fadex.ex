defmodule Fadex do

  def connect(host \\ "127.0.0.1", port \\ 7890, options \\ []) do
    defaults = [timeout: 10000]
    options = Keyword.merge(defaults, options) |> Enum.into(%{})

    host = String.to_charlist host
    tcp_options = [:binary]
    case :gen_tcp.connect(host, port, tcp_options, options.timeout) do
      {:error, err} -> {:error, err}
      {:ok, port} -> {:ok, %Fadex.Connection{socket: port}}
    end
  end

  def disconnect(%Fadex.Connection{socket: socket}) do
    :gen_tcp.close socket
  end

  defp prepare_pixels(pixels) do
    filtered = Enum.filter pixels, fn(color) ->
      case color do
        {_, _, _} -> false
        true -> true
      end
    end

    if length(filtered) > 0 do
      {:error, :color_tuple_error}
    else
      pixels = Enum.map pixels, fn ({r, g, b}) ->
        {
          min(255, max(0, round(r))),
          min(255, max(0, round(g))),
          min(255, max(0, round(b)))
        }
      end

      {:ok, pixels}
    end
  end

  def send_pixels(conn, pixels), do: send_pixels(conn, 0, pixels)
  def send_pixels(%Fadex.Connection{socket: socket}, channel, pixels)
      when length(pixels) in 0..65536 and channel in 0..255
      and is_integer(channel) do
    case prepare_pixels pixels do
      {:error, err} -> {:error, err}
      {:ok, pixels} ->
        pixels = Enum.map pixels, fn ({r, b, g}) -> [r, b, g] end
        pixels = List.flatten pixels

        message = [
          channel,
          0,
          round(Float.floor(length(pixels) / 256)),
          rem(length(pixels), 256)
        | pixels]

        bin = :binary.list_to_bin message
        :gen_tcp.send(socket, bin)
    end
  end

  def n_list(0), do: []
  def n_list(n) do
    [{255, 255, 255} | n_list(n - 1)]
  end
end
