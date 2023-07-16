
defmodule Lora do
  def start_gateway do
    loraNodeConfig = %{lora: AppConfig.lora_config(:sx127x), call_handler: &handle_call/2}
    {:ok, _loraNode} = :lora_node.start(:robert, loraNodeConfig)
    :io.format(~c"Lora server started.  Waiting to receive requests...~n")
  end
  defp handle_call({:hello, i} = _message, context) do
    from = :maps.get(:from, context)
    :io.format(~c"Received {hello, ~p} from ~p...~n", [i, from])
    {:hello, from}
  end

  defp handle_call(_message, _context) do
    :buzz_off
  end

  def start_client do
    :ok #todo
  end
end
