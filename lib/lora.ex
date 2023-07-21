defmodule Lora do
  def start_gateway() do
    # loraNodeConfig = %{lora: AppConfig.lora_config(:sx127x), call_handler: &handle_call/2}
    # {:ok, _loraNode} =
    # :lora_node.start(:robert, loraNodeConfig)

    # :io.format(~c"Lora server started.  Waiting to receive requests...~n")
  end


  def start_client() do
    loraConfig = AppConfig.lora_config(:sx127x)
    {:ok, lora} = :lora.start(loraConfig)
    :io.format("Lora Client started")
    lora
  end


  def send_lora(Device, Payload) do
    #payload = ["AtomVM ", :erlang.integer_to_list(i)]
    try do
      case(:lora.broadcast(Device,Payload)) do
        :ok ->
          :io.format(~c"Sent ~p~n", [Payload])
        error ->
          :io.format(~c"Error sending: ~p~n", [error])
      end
    catch
      :exit, :timeout ->
        :io.format(~c"Timed out broadcasting ~p~n", [Payload])
    end
  end
end
