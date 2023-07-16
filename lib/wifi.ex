# Generated by erl2ex (http://github.com/dazuma/erl2ex)
# From Erlang source: c:/Users/pip43/Documents/Projects/lora_tranciever/lib/wifi.erl
# At: 2023-07-15 19:06:53

defmodule Wifi do
  def start_network() do
    config = [
      sta: [
        {:connected, &connected/0},
        {:got_ip, &got_ip/1},
        {:disconnected, &disconnected/0} | :maps.get(:sta, AppConfig.wifi())
      ],
      sntp: [host: ~c"pool.ntp.org", synchronized: &date_info/0]
    ]

    case(:network.start(config)) do
      {:ok, _pid} ->
        :timer.sleep(:infinity)

      error ->
        error
    end
  end

  defp connected() do
    :io.format(~c"Connected to wireless access point.~n")
  end

  defp got_ip(ipInfo) do
    :io.format(~c"Assigned IP: ~p.~n", [ipInfo])
  end

  defp disconnected() do
    :io.format(~c"Disconnected from wireless access point.~n")
  end

  defp date_info() do
    {{year, month, day}, {hour, minute, second}} = :erlang.universaltime()

    :io.format(~c"Date: ~p/~p/~p ~p:~p:~p (~pms)~n", [
      year,
      month,
      day,
      hour,
      minute,
      second,
      :erlang.system_time(:millisecond)
    ])
  end
end
