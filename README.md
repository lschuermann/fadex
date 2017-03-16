# fadex - OpenPixelControl for Elixir
With fadex you can control your OpenPixelControl-Protocol supporting devices using Elixir.

### Important notice
I'm fairly new to Elixir and this library is in Alpha stage, so the API will be subject to change. Feel free to test it, send me feature-request or do pull requests!

## Usage
Start a new Connection:
```elixir
iex> {:ok, conn} = Fadex.connect("127.0.0.1", 7890)
{:ok, %Fadex.Connection{socket: #Port<#.####>}}
```

In Fadex, Pixels are represented as a list of 3-tuples with RGB-Values between `0` and `255`.

To set 3 pixels to either red, green and blue, use the following function-call:
```elixir
iex> Fadex.send_pixels(conn, [{255, 0, 0}, {0, 255, 0}, {0, 0, 255}])
:ok
```

Finally, to disconnect from the OpenPixelControl-Server, use
```
iex> Fadex.disconnect(conn)
:ok
```

## License
This library is licensed under the terms of the Apache-2.0 License. See [`LICENSE.txt`](https://github.com/lschuermann/fadex/blob/master/LICENSE.txt) for more information.
