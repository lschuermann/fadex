defmodule Fadex.Fadecandy do
  use Bitwise

  def set_configuration(%Fadex.Connection{socket: socket}, config) do
    defaults = [
      dithering: :enabled,
      keyframe_interpolation: :enabled,
      led_mode: :usb
    ]
    config = Keyword.merge(defaults, config) |> Enum.into(%{})
    config_byte = 0x00

    config_byte = if (config.dithering == :disabled),
      do: config_byte ^^^ (1 <<< 0), else: config_byte

    config_byte = if (config.keyframe_interpolation == :disabled),
      do: config_byte ^^^ (1 <<< 1), else: config_byte

    

    message = [
      0x00,
      0xFF,
      0x00, 1 + 4,
      0x00, 0x01,
      0x00, 0x02,
      config_byte
    ]

    bin = :binary.list_to_bin message
    IO.puts inspect bin
    :gen_tcp.send(socket, bin)
  end
end
